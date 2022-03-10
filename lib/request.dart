import 'package:dio/dio.dart';
import 'package:maby_dio/default_target_api.dart';
import 'package:maby_dio/target_api.dart';


TargetApi kDefaultTargetApi = DefaultTargetApi();

 class Request {
  final Dio _dio = Dio();

  request(TargetApi? api) {
    TargetApi _api = api ?? kDefaultTargetApi;
    _dio.options.baseUrl = _api.baseUrl;
    _dio.request('');
  }
}