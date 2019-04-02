import "package:dio/dio.dart";
Dio Http(){
  Dio dio = new Dio();
  dio.options.baseUrl = 'http://funplay.carvenzhang.cn';
  return dio;
}