
import 'package:dio/dio.dart';
import 'package:maby_dio/codable.dart';
import 'package:maby_dio/http_error.dart';
import 'package:maby_dio/response_serialize.dart';
import 'package:maby_dio/response_data.dart';

class HttpResponse<T extends Codable> {
  ResponseSerializer? serializer;
  Response? response;
  bool success = false;
  int code = 0;
  String? message;
  HttpError? error;
  RawResponseData? data;

  HttpResponse(this.response, this.serializer, T? busModel) : code = response?.statusCode ?? 0 {
    if (response == null) return;
    success = _isSuccess(response!);
    serializer ??= DefaultResponseSerializer();
    message = response?.statusMessage;
    if (success) {
      data = serializer?.serialize(response!, busModel);
    } else {
      error = HttpError.request(code, message);
    }
  }

  HttpResponse.exception(Exception e){
      error = HttpError.dioError(e);
  }

  bool _isSuccess(Response response) {
    if (response.statusCode == null) return false;
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}