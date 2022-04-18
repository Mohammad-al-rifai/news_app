import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper
{
  static Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        // baseUrl: 'http://10.0.2.2:8000/api/',
        baseUrl: 'http://192.168.43.21:88/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );
  }


  static Future<Response> getData({
  @required String url,
    Map<String , dynamic> query,
    String token,
})
  async{
    dio.options.headers = {
      'Accept':'application/json',
      'Authorization' : 'Bearer $token',
    };
    return await dio.get(
        url,
        queryParameters: query,
    );
  }


  static Future<Response> postData({
    @required String url,
    Map<String , dynamic> query,
    @required var data,
    // @required FormData data,
    String token,
  })
  async{
    dio.options.headers = {
      'Accept':'application/json',
      'Authorization' : 'Bearer $token',
    };
    return  dio.post(
      url,
      queryParameters: query,
      data: data,

    );
  }



  // =======================

  // static Future<Response> postData1({
  //   @required String url,
  //   @required var data,
  //   String token,
  // })
  // async{
  //   dio.options.headers = {
  //     'Accept':'application/json',
  //     'Authorization' : 'Bearer $token',
  //   };
  //   return  dio.post(
  //     url,
  //     data: data,
  //   );
  // }

  // =======================


  static Future<Response> putData({
    @required String url,
    @required Map<String , dynamic> data,
    String token,
  })
  async{
    dio.options.headers = {
      'Accept':'application/json',
      'Authorization' : 'Bearer $token',
    };
    return  dio.put(
      url,
      data: data,
    );
  }



  static Future<Response> deleteData({
    @required String url,
    String token,
  })
  async{
    dio.options.headers = {
      'Accept':'application/json',
      'Authorization' : 'Bearer $token',
    };
    return  dio.delete(
      url,
    );
  }


}




