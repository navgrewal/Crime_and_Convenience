//import 'dart:js';

import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Services/authservice.dart';
import './forgotpassword.dart';
class SignIn extends StatefulWidget {
  

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool islogingin=false;
  TextEditingController emailCon =TextEditingController();
  TextEditingController passwordCon =TextEditingController();
  List loginDetails;
  signIn(){
    setState(() {
      islogingin=true;
      print(islogingin);
    });
    AuthService().login(emailCon.text, passwordCon.text).then((val){
      if (val.data!=null){
        print(val.data['token']);
        loginDetails=[val.data['token'],val.data['name'],emailCon.text,passwordCon.text];
        print(loginDetails);
        if (loginDetails[0]!=null){
          Navigator.pop(context,loginDetails);
        }
        else{
          Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);
        }
        setState(() {
          islogingin=false;
        });
      }
      else{setState(() {
          islogingin=false;
        });
        print("wrong");}
    });
    
  }

  @override
  Widget build(BuildContext context) {
    print(islogingin);
    return Scaffold(
       body: ListView(
         children: [
           Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.25,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),),
              child: Container(
                alignment: AlignmentDirectional(0,1),
                padding: EdgeInsets.only(bottom: 20),
                child: 
                  Text(
                    "Crime & Convenience",
                    style: TextStyle(
                        fontFamily: "Signatra",
                        color: Colors.white,
                        fontSize: 55),
                  ),
                
              ),),islogingin ? linearProgress(context):Text(""),
         Container( padding: EdgeInsets.all(15),alignment: AlignmentDirectional.center ,child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [TextField(controller: emailCon,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                       labelText: "Email",
                     ),),
                     Padding(padding: EdgeInsets.only(bottom: 20)),
                     TextField(obscureText: true,controller: passwordCon,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                       labelText: "Password",
                     ),),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    FlatButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPass()));
                    }, child: Text("Forgot Password"))
                     ,ElevatedButton (child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 15,horizontal:30 ),
                       child: Text("LOGIN",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     ),onPressed: signIn,)
                     ],
         ),)],
       ),
    );
  }
}

