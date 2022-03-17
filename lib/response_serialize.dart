
import 'package:dio/dio.dart';
import 'package:maby_dio/codable.dart';
import 'package:maby_dio/response_data.dart';

abstract class ResponseSerializer<T extends Codable> {
    RawResponseData serialize(Response response, T? model);
}

class DefaultResponseSerializer<T extends Codable> extends ResponseSerializer<T> {
  @override
  RawResponseData serialize(Response response, T? model) {
    dynamic data = response.data;
    if (data is Map) {
      dynamic innerData = data['data'];
      if (model != null && innerData is Map<String, dynamic>) {
        model.fromJson(innerData);
        return ResponseModelData(model);
      }
      return ResponseRawData(innerData);
    }
    return ResponseRawData(data);
  }  
}