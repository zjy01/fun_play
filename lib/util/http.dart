import "package:dio/dio.dart";
import './const.dart';
Dio Http(){
  Dio dio = new Dio();
  dio.options.baseUrl = HOST;
  return dio;
}