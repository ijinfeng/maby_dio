import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maby_dio/default_config.dart';
import 'package:maby_dio/response.dart';
import 'package:maby_dio/response_serialize.dart';
import 'package:maby_dio/target_api.dart';
import 'package:maby_dio/codable.dart';

class HttpRequest {
  final Dio _dio = Dio();

  final Map<String, CancelToken> _cancelMap = {};

  HttpRequest({TargetApi? api}) {
    api ??= DefaultTargetApi(HttpDefaultConfig().defaultBaseUrl);
    _dio.options.baseUrl = api.baseUrl;
    _dio.options.contentType = api.contentType;
    _dio.options.connectTimeout = api.connectTimeout;
    _dio.options.sendTimeout = api.sendTimeout;
    _dio.options.receiveTimeout = api.receiveTimeout;
    _dio.options.headers = api.headers;
    // debug模式下打印请求
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: true,
          requestBody: true));
    }
    if (api.interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(api.interceptors!);
    }
    if (api.proxy != null) {
      _dio.httpClientAdapter = DefaultHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          // "PROXY host:port"
          // "DIRECT"
          client.findProxy = (url) {
            return 'PROXY ${api?.proxy}';
          };
        };
    }
  }
}

extension HTTP<T extends Codable> on HttpRequest {
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParamaters,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    _dio.options.method = 'GET';
    return _request(path,
        queryParamaters: queryParamaters,
        headers: headers,
        serializer: serializer,
        model: model);
  }

  Future<HttpResponse> post(String path,
      {Map<String, dynamic>? queryParamaters,
      data,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    _dio.options.method = 'POST';
    return _request(path,
        queryParamaters: queryParamaters,
        data: data,
        headers: headers,
        serializer: serializer,
        model: model);
  }

  Future<HttpResponse> patch(String path,
      {Map<String, dynamic>? queryParamaters,
      data,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    _dio.options.method = 'PATCH';
    return _request(path,
        queryParamaters: queryParamaters,
        data: data,
        headers: headers,
        serializer: serializer,
        model: model);
  }

  Future<HttpResponse> delete(String path,
      {Map<String, dynamic>? queryParamaters,
      data,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    _dio.options.method = 'DELETE';
    return _request(path,
        queryParamaters: queryParamaters,
        data: data,
        headers: headers,
        serializer: serializer,
        model: model);
  }

  Future<HttpResponse> put(String path,
      {Map<String, dynamic>? queryParamaters,
      data,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    _dio.options.method = 'PUT';
    return _request(path,
        queryParamaters: queryParamaters,
        data: data,
        headers: headers,
        serializer: serializer,
        model: model);
  }

  Future<HttpResponse> _request(String path,
      {Map<String, dynamic>? queryParamaters,
      data,
      Map<String, dynamic>? headers,
      ResponseSerializer? serializer,
      T? model}) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    CancelToken? token = _cancelMap[path];
    if (token == null) {
      token = CancelToken();
      _cancelMap[path] = token;
    }
    try {
      Response response = await _dio.request(path,
          queryParameters: queryParamaters, data: data, cancelToken: token);
      return _handleResponse(response, serializer, model: model);
    } on Exception catch (e) {
      return HttpResponse.exception(e);
    }
  }

  HttpResponse _handleResponse(
      Response response, ResponseSerializer? serializer,
      {T? model}) {
    serializer ??= DefaultResponseSerializer();
    return HttpResponse(response, serializer, model);
  }

  /// 取消网络请求
  cancel({String? path}) {
    CancelToken? token = _cancelMap[path];
    if (token != null) {
      token.cancel();
    } else {
      _cancelMap.forEach((key, value) {
        value.cancel();
      });
    }
  }
}
