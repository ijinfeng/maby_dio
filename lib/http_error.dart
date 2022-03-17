import 'package:dio/dio.dart';

enum HttpErrorType {
  unknown,
  request,
  badServer,
  timeout,
  cancel,
}

class HttpError implements Exception {
  final HttpErrorType type;
  final int code;
  final String? message;

  HttpError.request(this.code, this.message) : type = HttpErrorType.request;

  HttpError.badServer(this.code, this.message) : type = HttpErrorType.badServer;

  HttpError.unknown(this.message)
      : code = 0,
        type = HttpErrorType.unknown;

  HttpError.timeout(this.message)
      : code = 0,
        type = HttpErrorType.timeout;

  HttpError.cancel(this.message)
      : code = 0,
        type = HttpErrorType.cancel;

  factory HttpError.dioError(Exception error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return HttpError.timeout(error.message);
        case DioErrorType.cancel:
          return HttpError.cancel(error.message);
        case DioErrorType.response:
          int code = error.response?.statusCode ?? 0;
          switch (code) {
            case 400:
              return HttpError.request(code, '请求报文存在语法错误');
            case 401:
              return HttpError.request(code, '没有权限');
            case 403:
              return HttpError.request(code, '服务器拒绝执行');
            case 404:
              return HttpError.request(code, '无法连接服务器');
            case 405:
              return HttpError.request(code, '请求方法被禁止');
            case 500:
              return HttpError.badServer(code, '服务器内部错误');
            case 501:
              return HttpError.badServer(code, '服务器不支持当前请求');
            case 502:
              return HttpError.badServer(code, '无效请求');
            case 503:
              return HttpError.badServer(code, '服务器挂了');
            case 505:
              return HttpError.badServer(code, '不支持的HTTP版本');
            default:
              return HttpError.unknown(error.message);
          }
        default:
          return HttpError.unknown(error.message);
      }
    } else {
      return HttpError.unknown(error.toString());
    }
  }
}
