
import 'package:maby_dio/target_api.dart';

class DefaultTargetApi extends TargetApi {
  final String _baseUrl;

  DefaultTargetApi(this._baseUrl);

  @override
  String get baseUrl => _baseUrl;  
}