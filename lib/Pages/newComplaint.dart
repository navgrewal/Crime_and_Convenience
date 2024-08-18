import 'package:Crime_and_Convenience/Services/complaintService.dart';
import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NewComplaint extends StatefulWidget {
  
  
  NewComplaint();


  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  
  final _formkey = GlobalKey<FormState>();
  bool isRegistering=false;
  TextEditingController addressCon=new TextEditingController();
    TextEditingController detailCon=new TextEditingController();
    String category;

  _NewComplaintState();

    submitComplaint(){
      if (_formkey.currentState.validate()){
      
      
      if (category==null){Fluttertoast.showToast(msg: "Please select category",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);}
      else{
        setState(() {
          isRegistering=true;
        });
        ComplaintService().register(text: detailCon.text,address: addressCon.text,category: category).then(
          (val){
            if (val!=null){
              print(val);
              if(val.data['status']!=null){
                Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.red,textColor: Colors.white,fontSize: 16);
              }
              else{
                Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.green,textColor: Colors.white,fontSize: 16);
              setState(() {
                isRegistering=false;
              });
              Navigator.pop(context);
              }
            }
          }
        );
        
      }
      }
    }

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      appBar: AppBar(title: Text("Register Complaint"),),
      body: ListView(padding: EdgeInsets.symmetric(horizontal: 15),children: [
              isRegistering?linearProgress(context):Text(""),
              Form(key: _formkey,child: Column(
                children: [
                  TextFormField(
                    validator: (input){if (input.length==0)return"Please enter details about complaint"; else return null;},
                    keyboardType: TextInputType.multiline,maxLines: null,controller: detailCon,
                    decoration: InputDecoration(labelText:"Complaint Detail")),
                    TextFormField(validator: (input){if (input.length==0)return"Please enter your address"; else return null;},
                    keyboardType: TextInputType.multiline,maxLines: null,controller: addressCon,decoration: InputDecoration(labelText:"Address"), )
              ,
                ],
              )),
              Padding(padding: EdgeInsets.only(bottom: 20))
              ,DropdownButton<String>(hint: Text("Category"),isExpanded: true,
      value: category,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          category = newValue;
        });
      },
      items: <String>['Water', 'Electricity', 'Road', 'Swachh Bharat','Animal Control']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
              ,Padding(padding: EdgeInsets.only(bottom: 25)),
              Container(alignment:AlignmentDirectional(1, 0),
              child: RaisedButton(color: Theme.of(context).primaryColor,
              textColor: Colors.white,child: Text("Register",style: TextStyle(fontSize: 19),),onPressed:submitComplaint ))
            ],),
    );
  }
}