import 'package:Crime_and_Convenience/Services/authservice.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isSignup=false;
  final _formkey = GlobalKey<FormState>();
  String email,password,name;

  signUp(){
    if (_formkey.currentState.validate()){
      _formkey.currentState.save();
      setState(() {
        isSignup=true;
      });
      AuthService().signup(name, email, password).then((val){
        if (val!=null){
          print(val.data);
          Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.green,textColor: Colors.white,fontSize: 16);
          setState(() {
        isSignup=false;
          });
          Navigator.pop(context);
        }
        else{setState(() {
        isSignup=false;
          });
          print("wrong");}
      });
      
    }
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
                
              ),),isSignup? linearProgress(context):Text(""),
         Container( padding: EdgeInsets.all(10),alignment: AlignmentDirectional.center ,child: Form(
           key: _formkey,
                    child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [TextFormField(onSaved: (input){name=input;},
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                         labelText: "Name",
                       ),),
                       Padding(padding: EdgeInsets.only(bottom: 20)),
                       TextFormField(onSaved: (input){email=input;},
                       validator: (input){
                         Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(input))
                            return 'Enter Valid Email';
                           else
                          return null;},
                       decoration: InputDecoration(
                      border: OutlineInputBorder(),
                         labelText: "Email",
                       ),),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                       TextFormField(obscureText: true,
                       onSaved: (input){password=input;},
                       validator: (input){if(input.length<8)return "Password is short"; else return null; },
                       decoration: InputDecoration(
                      border: OutlineInputBorder(),
                         labelText: "Password",
                       ),),
                       ],
           ),
         ),),Padding(padding: EdgeInsets.only(bottom: 20)),ElevatedButton (child: Padding(
                         padding: const EdgeInsets.symmetric(vertical: 15,horizontal:30 ),
                         child: Text("SIGNUP",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                       ),onPressed: signUp,)],
       ),
    );
  }
}