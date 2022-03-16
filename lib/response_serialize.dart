
import 'package:dio/dio.dart';
import 'package:maby_dio/response.dart';

abstract class ResponseSerializer {
    HttpResponse serialize(Response response);
}

class DefaultResponseSerializer extends ResponseSerializer {

  /*
  {
    "code": 200,
    "data": {},
    "message": ""
  }
  */

  @override
  HttpResponse serialize(Response response) {
    // TODO: implement serialize
    throw UnimplementedError();
  }

}