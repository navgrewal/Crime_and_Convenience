import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './globals.dart' as globals;

class ComplaintService{
  Dio dio= new Dio();
  var token=globals.token;
  var baseUrl = globals.baseUrl;
  
  register({text,address,category}) async{
    try{
      print("nav");
      return await dio.post(baseUrl + 'complaint/',data: {"text":text,"address":address,
      "category":category},
      options: Options(headers: {"Authorization":'Bearer $token'},contentType: Headers.formUrlEncodedContentType));
    }on DioError catch (error){print("object");print(error.response.data['message']);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

  getComplaints() async{
    try{
      print("nav");
      print(token);
      return await dio.get(baseUrl + 'complaint/mycomplaint',
      options: Options(headers: {"Authorization":'Bearer $token'},contentType: Headers.formUrlEncodedContentType,));
      
    }on DioError catch (error){print("object");print(error.response.data);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

  deleteComplaint({complaintID}) async{
    
    try{
      print("nav");
      
      return await dio.delete(baseUrl + 'complaint/$complaintID',
      options: Options(headers: {"Authorization":'Bearer $token'},contentType: Headers.formUrlEncodedContentType,validateStatus: 
      (status){return status<400;}));
    }on DioError catch (error){print("object");print(error.response.data);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }
}