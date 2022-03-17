import 'package:flutter_test/flutter_test.dart';

import 'package:maby_dio/maby_dio.dart';

void main() {
  test('adds one to input values', () {
    //接口测试 https://github.com/shichunlei/-Api/blob/master/OneArticle.md
    
    HttpDefaultConfig().invoke('https://interface.meiriyiwen.com');

    HttpRequest().get('/article/today', queryParamaters: {"dev": 1}).then((value) {
      print(value.data);
    }).whenComplete(() => print('结束'));
    print('好了');

    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
  });
}
