import 'package:Crime_and_Convenience/Services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPass extends StatefulWidget {
  

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailCon=TextEditingController();


  sendEmail(){
    AuthService().forgotPass(emailCon.text).then((val){
      if (val!=null){
        print(val.data);
        Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.green,textColor: Colors.white,fontSize: 16);
      Navigator.pop(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
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
                
              ),),
         Container( padding: EdgeInsets.all(15),alignment: AlignmentDirectional.center ,child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [TextField(controller: emailCon,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                       labelText: "Email",
                     ),),
                     Padding(padding: EdgeInsets.only(bottom: 20))
                     ,ElevatedButton (child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 15,horizontal:30 ),
                       child: Text("Send Reset Code",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     ),onPressed: sendEmail,)
                     ],
         ),)],
       ),
    );
  }
}