
import 'package:Crime_and_Convenience/Pages/bolo.dart';
import 'package:Crime_and_Convenience/Pages/signup.dart';
import 'package:Crime_and_Convenience/Services/authservice.dart';
import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import './signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './complaints.dart';
import 'news.dart';
import './updates.dart';
import '../Services/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email','profile']);

class Home extends StatefulWidget {
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;
  GoogleSignInAccount googleAccount;
  bool isAuth=false;
  PageController pageController;
  int pageIndex=0;
  List loginDetails;
  var token;
  var name;var email;var password;
  @override
  void initState() { 
    super.initState();
    pageController=PageController();
    // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   setState(() {
    //     googleAccount=account;
    //   });
    //  });
    //  googleSignIn.signInSilently();
    checkSignin();
  }

  checkSignin() async{
    prefs = await SharedPreferences.getInstance();
    email=prefs.getString('email' ?? "");
    password=prefs.getString('password' ?? "");
    if (email!=null){
    AuthService().login(email, password).then((val){
          if(val.data!=null){
            token=val.data['token'];
            name=val.data['name'];
            if (token!=null){
            globals.token=token;
            setState(() {
              isAuth=true;
            });}
          }
        });
    }
    
  }

  @override
  void dispose() { 
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int index){
    setState(() {
      this.pageIndex=index;
    });
  }

  onTap(int pageIndex){
    print("tap");
    
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  signOut() async{
    await prefs.clear();
    print(prefs.getString('token') ?? "");
    setState(() {
      isAuth=false;
    });

  }

  Scaffold auth(){
    return Scaffold(
          drawer: Drawer(child: Column(children: [UserAccountsDrawerHeader(accountName: Text(name), 
          accountEmail:Text(email) ),ListTile(onTap: (){launch("https://ecom-admin-dashboard.herokuapp.com/login");},
          title: Text("Admin Dashboard"),),
          ListTile(onTap: signOut,title: Text("Logout"),),
          Expanded(
                child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Made with ",style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 20),),
                Icon(Icons.favorite,color: Theme.of(context).primaryColor,),
                Text(" by 58,59,64  ",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),)],),
              )],),),
          appBar: appBarWidget(),
          body: PageView(children: [News(),
        Updates(),Bolo(),
        Complaints(),
      ],
      onPageChanged: onPageChanged,
      controller: pageController,),
      bottomNavigationBar: CupertinoTabBar(activeColor: Theme.of(context).primaryColor,
      currentIndex: pageIndex, onTap: onTap,
      items: [BottomNavigationBarItem(label: "News",icon: Icon(Icons.calendar_today)),
        BottomNavigationBarItem(label:"Updates",icon: Icon(Icons.notifications_active)),
        BottomNavigationBarItem(label:"BOLO",icon: Icon(Icons.remove_red_eye)),
      BottomNavigationBarItem(label:"Complaints",icon: Icon(Icons.error_outline)),]
      ),
    );
  }

  Future<void> handleGSignin() async{
    try{await googleSignIn.signIn();}
    catch(error){print(error);print("error");
    print(googleAccount);}
  }

  Scaffold unauth() {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ]),),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2)),
              Text(
                "Crime & Convenience",
                style: TextStyle(
                    fontFamily: "Signatra",
                    color: Colors.white,
                    fontSize: 55),
              ),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2)),
              GestureDetector(
                onTap: () async {
                  loginDetails=await Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                  token=loginDetails[0];
                  name=loginDetails[1];email=loginDetails[2];password=loginDetails[3];
                  print(token);
                  if (token!=null){
                    globals.token=token;
                    await prefs.setString('email',email);
                    await prefs.setString('password',password);
                    setState(() {
                      isAuth=true;
                    });
                  }
                  },
                child: Container(
                  decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 3),borderRadius: BorderRadius.circular(30) ),
                  
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
                  ),)  ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              GestureDetector(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                  },
                child: Container(
                  decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 3),borderRadius: BorderRadius.circular(30) ),
                  
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: Text("SIGNUP",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
                  ),)  ),
              ),
              /*Padding(padding: EdgeInsets.only(bottom: 15)),
              GestureDetector(
                onTap: (){
                    handleGSignin();
                  },
                child: Container(
                  decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 3),borderRadius: BorderRadius.circular(30) ),
                  
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.1,
                  alignment: AlignmentDirectional.center,
                  child: Text("Signin With Google",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
                  ),)  ),
              )*/
              Expanded(
                child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Made with ",style: TextStyle(color:Colors.white,fontSize: 20),),
                Icon(Icons.favorite,color: Colors.white,),
                Text(" by 58,59,64  ",style: TextStyle(color: Colors.white,fontSize: 20),)],),
              )
            ],
          )),
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? auth() : unauth();
  }

}