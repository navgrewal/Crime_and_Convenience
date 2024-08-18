import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './globals.dart' as globals;

class UpdateService{
  Dio dio=new Dio();
  var baseUrl = globals.baseUrl;
  getUpdates() async{
    try{
      print("nav");
      return await dio.get(baseUrl + 'update/',
      options: Options(contentType: Headers.formUrlEncodedContentType,validateStatus: 
      (status){return status<400;}));
      //print(temp.data);
      //return temp.data;
    }on DioError catch (error){print("object");print(error.response.data);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

}