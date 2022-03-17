import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maby_dio/maby_dio.dart';


class CustomModel extends Codable {
  String? author;
  String? title;

  @override
  fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class CustomTargetApi extends TargetApi {
  @override
  String get baseUrl => 'your base url';
}


void main() {
  test('dio test', () async {
    //接口测试 https://github.com/shichunlei/-Api/blob/master/OneArticle.md
    
    // HttpDefaultConfig().initialize('https://interface.meiriyiwen.com');

//     Wenzhang wz = Wenzhang();
//     HttpRequest().get('https://interface.meiriyiwen.com/article/today', queryParamaters: {"dev": 1}, model: wz).then((res) {
// print('好了--${wz.digest}');
//     print('author--${wz.author}');
//     } ).whenComplete(() {
//       print('完成');
//     });
    
CustomModel model = CustomModel();
HttpResponse res = await HttpRequest(api: CustomTargetApi()).get('/article/today', model: model);
print(model.title);


  Dio _dio = Dio();
_dio.get('https://interface.meiriyiwen.com/article/random', queryParameters: {'dev' : 1}).then((res) {
print(res.data);
}).whenComplete(() => print('+++++++++'));
print('========dio reposne');



    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
  });
}
