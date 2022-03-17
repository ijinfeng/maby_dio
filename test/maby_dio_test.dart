import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maby_dio/maby_dio.dart';


class Wenzhang extends Codable {
  Map? date;
  String? author;

  String? title;

  String? digest;

  @override
  fromJson(Map<String, dynamic> json) {
    date = json['date'];
    author = json['author'];
    title = json['title'];
    digest = json['digest'];
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }


}

void main() {
  test('dio test', () {
    //接口测试 https://github.com/shichunlei/-Api/blob/master/OneArticle.md
    
    // HttpDefaultConfig().initialize('https://interface.meiriyiwen.com');

//     Wenzhang wz = Wenzhang();
//     HttpRequest().get('https://interface.meiriyiwen.com/article/today', queryParamaters: {"dev": 1}, model: wz).then((res) {
// print('好了--${wz.digest}');
//     print('author--${wz.author}');
//     } ).whenComplete(() {
//       print('完成');
//     });
    


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
