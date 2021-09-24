import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          connectTimeout: 60*1000,
          receiveTimeout: 60*1000,

        ),
    );
  }

  static Future<Response> getData({required String url, String? token , })async
  {
    dio.options.headers = {
      'Authorization': token ?? " ",
      'lang':'en',
      'Content-Type':'application/json'
    };
    return  dio.get(url);

  }

  static Future<Response> postData({
    required String url ,
    Map<String,dynamic>? query,
    String? token,
    required Map<String,dynamic> data,
})async{
    dio.options.headers={
      'Authorization':token ?? " ",
      'lang':'en',
      'Content-Type':'application/json'
    };
     return dio.post(url, data: data,queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic> ?query,
    required Map<String,dynamic> data,
    String? token

}) async{
    dio.options.headers ={
      'Authorization': token?? " ",
      'lang':'en',
      'Content-Type':'application/json'
    };
    return dio.put(url, data: data,queryParameters: query);
  }

  static Future<Response> searchData({
  required String url,
  Map<String,dynamic>? query,
  required Map<String,dynamic>? data,
  String? token,
})async{
    dio.options.headers = {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization': token?? " ",
    };
    return dio.post(url,queryParameters: query,data: data);
}
}

