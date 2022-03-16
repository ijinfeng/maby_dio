import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maby_dio/default_target_api.dart';
import 'package:maby_dio/response.dart';
import 'package:maby_dio/target_api.dart';


TargetApi kDefaultTargetApi = DefaultTargetApi('');



class HttpRequest {
  final Dio _dio = Dio();

  HttpRequest(TargetApi? api) {
    api ??= kDefaultTargetApi;
    _dio.options.baseUrl = api.baseUrl;
    _dio.options.contentType = api.contentType;
    _dio.options.connectTimeout = api.connectTimeout;
    _dio.options.sendTimeout = api.sendTimeout;
    _dio.options.receiveTimeout = api.receiveTimeout;
    _dio.options.headers = api.headers;
    // debug模式下打印请求
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: true,
          requestBody: true
        )
      );
    }
    if (api.interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(api.interceptors!);
    }
    if (api.proxy != null) {
      _dio.httpClientAdapter = DefaultHttpClientAdapter()..onHttpClientCreate = (client) {
        // "PROXY host:port"
        // "DIRECT"
        client.findProxy = (url) {
          return 'PROXY ${api?.proxy}';
        };
      };
    }
  }
}

extension HTTP on HttpRequest {
  Future<HttpResponse> get(String path, {Map<String, dynamic>? queryParamaters, data, Map<String, dynamic>? headers}) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    Response response = await _dio.request(path, queryParameters: queryParamaters, data: data);
    return _handleResponse(response);
  }

  HttpResponse _handleResponse(Response response) {
    return HttpResponse();
  }
}