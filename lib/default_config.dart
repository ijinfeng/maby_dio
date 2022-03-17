
class HttpDefaultConfig {

  static final HttpDefaultConfig _instance = HttpDefaultConfig._internal();

  HttpDefaultConfig._internal();

  factory HttpDefaultConfig() => _instance;

  HttpDefaultConfig get shared => _instance;

/// 默认域名地址
  late final String _defaultBaseUrl;

  void invoke(String baseUrl) {
    _instance._defaultBaseUrl = baseUrl;
  }

  String get defaultBaseUrl => _defaultBaseUrl;
}