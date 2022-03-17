<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->


dio网络库封装。

## Features

* download接口支持
* upload接口支持
* 请求数据缓存支持

## Getting started

打开`pubspec.yaml`文件，输入：`maby_dio: ^0.0.1`

## Usage

### 普通使用

```dart
HttpResponse res = await HttpRequest().get('/article/today');
print(res.data?.responseData);
```

### 自定义TargetApi

```dart
class CustomTargetApi extends TargetApi {
  @override
  String get baseUrl => 'your base url';
}

HttpResponse res = await HttpRequest(api: CustomTargetApi()).get('/article/today');
print(res.data?.responseData);
```

### 响应数据自动解析为模型数据

```dart
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

CustomModel model = CustomModel();
HttpResponse res = await HttpRequest(api: CustomTargetApi()).get('/article/today', model: model);
print(model.title);
```

