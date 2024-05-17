import 'dart:convert';

import 'package:dio/dio.dart';

const String baseUrl = "http://192.168.1.185:3000/";

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      sendTimeout: Duration(milliseconds: 50000),
      receiveTimeout: Duration(milliseconds: 50000),
      responseType: ResponseType.json,
    ));
  }

  static Future<Response> postData(
      {required String url, Object? data, Map<String, dynamic>? header,Map<String,dynamic>? param}) async {
    return await dio.post(url,
        data: jsonEncode(data), options: Options(headers: header),queryParameters: param);
  }

  static Future<Response> getData(
      {required String url, Object? data, Map<String, dynamic>? header,Map<String,dynamic>? param}) async {
    return await dio.get(url,
        data: jsonEncode(data), options: Options(headers: header),queryParameters: param);
  }
  static Future<Response> getDataWithoutBody(
      {required String url, Map<String, dynamic>? header,Map<String,dynamic>? param}) async {
    return await dio.get(url,
         options: Options(headers: header),queryParameters: param);
  }
  static Future<Response> updateData(
      {required String url, Object? data, Map<String, dynamic>? header,Map<String,dynamic>? param}) async {
    return await dio.patch(url,
        data: jsonEncode(data), options: Options(headers: header),queryParameters: param);
  }
}
