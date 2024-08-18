import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './globals.dart' as globals;
class AuthService{
  Dio dio= new Dio();
  var baseUrl = globals.baseUrl;

  login(email,password) async{
    try{
      print("nav");
      return await dio.post(baseUrl + 'users/login',data: {"email":email,"password":password},
      options: Options(contentType: Headers.formUrlEncodedContentType,));
    } catch (error){print("object");print(error.response.data['message']);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

  signup(name,email,password) async{
    try{
      print("nav");
      return await dio.post(baseUrl + 'users/signup',data: {"email":email,"password":password,
      "name":name},
      options: Options(contentType: Headers.formUrlEncodedContentType,
      ));
    }on DioError catch(error){print("object");print(error.response);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

  forgotPass(email) async{
    try{
      print("nav");
      return await dio.post(baseUrl + 'users/forgotpass',data: {"email":email},
      options: Options(contentType: Headers.formUrlEncodedContentType,validateStatus: 
      (status){return status<400;}));
    }catch (error){print("object");print(error.response.data['message']);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }


  getU() async{
    try{
      print("nav");
      return await dio.get(baseUrl + 'users/5fcd9e516b78af004c1a3dd3',
      options: Options(contentType: Headers.formUrlEncodedContentType,validateStatus: 
      (status){return status<400;}));
    } catch (error){print("object");print(error.response.data['message']);
      Fluttertoast.showToast(msg: error.response.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
  }

}