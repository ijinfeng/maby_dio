
import 'package:dio/dio.dart';

abstract class TargetApi {
  String get baseUrl;

  String? get proxy => null;

  int get connectTimeout => 15000;

  int get sendTimeout => 15000;

  int get receiveTimeout => 15000;

  String get contentType => 'application/json';

  List<Interceptor>? get interceptors => null;

  Map<String, dynamic>? get headers => null;
}

class DefaultTargetApi extends TargetApi {
  final String _baseUrl;

  DefaultTargetApi(this._baseUrl);

  @override
  String get baseUrl => _baseUrl;  
}