

import 'package:maby_dio/codable.dart';

abstract class RawResponseData {

}

class ResponseModelData<T extends Codable> extends RawResponseData {
  T? data;
  ResponseModelData(this.data);
}

class ResponseRawData extends RawResponseData {
  dynamic data;
  ResponseRawData(this.data);
}