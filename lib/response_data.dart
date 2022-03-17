

import 'package:maby_dio/codable.dart';

abstract class RawResponseData {
  dynamic get responseData;
}

class ResponseModelData<T extends Codable> extends RawResponseData {
  final T? _data;
  ResponseModelData(this._data);

  @override
  get responseData => _data;
}

class ResponseRawData extends RawResponseData {
  final dynamic _data;
  ResponseRawData(this._data);

  @override
  get responseData => _data;
}