

//import 'dart:html';

import 'package:Crime_and_Convenience/Pages/newComplaint.dart';
import 'package:Crime_and_Convenience/Services/complaintService.dart';
import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Complaints extends StatefulWidget {
  
  Complaints({Key key}) : super(key: key);
  
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  
  _ComplaintsState(); 
  var complaints;
  
  bool isDeleting=false;
  @override
  void initState() { 
    getComplaints();
    
    super.initState();
    
  }

  showComplaintList(){
    if (complaints==null){
      return circularProgress(context);
    }else if (complaints['count']==0)return Center(child: Text("No Complaints",style: TextStyle(fontSize: 25,color: 
    Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),);
    return ListView.builder(itemCount: complaints['count'],itemBuilder: (context,index){
        return GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: 
        (context)=>ShowComplaint(complaints['complaints'][index])));},
                  child: Card(elevation: 5,margin: EdgeInsets.all(5),
                    child: ListTile(
            subtitle: Text(complaints['complaints'][index]['category'])
            ,trailing: Container(padding: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(width: 3,
            color:complaints['complaints'][index]['status']=="registered"?Colors.orange:Colors.green ),
            borderRadius: BorderRadius.circular(10)),
            child: Text(complaints['complaints'][index]['status'],style: TextStyle(fontWeight: FontWeight.bold,
            color: complaints['complaints'][index]['status']=="registered"?Colors.orange:Colors.green),)),
            title: Text(complaints['complaints'][index]['text'],style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        );
      });
  }
 
  getComplaints(){
    ComplaintService().getComplaints().then((val){
      if (val.data!=null){
      setState(() {
        complaints=val.data;  
      });}
      
      
    });
    
    
  }
  

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: RefreshIndicator(child: showComplaintList(), onRefresh: ()async=>getComplaints()) ,
       floatingActionButton: FloatingActionButton(backgroundColor: Theme.of(context).primaryColor,
       child:Icon(Icons.add,color: Colors.white,),onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewComplaint()));
       }),
    );
  }
}

class ShowComplaint extends StatefulWidget {
  var complaint;
  
  ShowComplaint(this.complaint);
  @override
  _ShowComplaintState createState() => _ShowComplaintState(this.complaint);
}

class _ShowComplaintState extends State<ShowComplaint> {
  var complaint;
  _ShowComplaintState(this.complaint);

  bool isDeleting=false;

  handleDelete(String complaintID){
    setState(() {
      this.isDeleting=true;
      print(isDeleting);
    });
    ComplaintService().deleteComplaint(complaintID:complaintID).then((val){
      if (val!=null){
        print(val.data);
        Fluttertoast.showToast(msg: val.data['message'],toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM
      ,backgroundColor:Colors.green,textColor: Colors.white,fontSize: 16);
       setState(() {
         this.isDeleting=false;
       });
      Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String address;
    String date=complaint['date'];
    date=date.substring(0,10);
    
    
    if (complaint['address']!=null)
      address='Address: '+complaint['address'];
    else address="";
    return Scaffold(appBar: appBarWidget(),body: Column(
      children: [isDeleting ? linearProgress(context):Text(""),
        Container(margin: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
        decoration: BoxDecoration(border: Border.all(width: 3,color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(15)),
              child: ListView(shrinkWrap: true,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          children: [Row(
            children: [
              Expanded(
                          child: Text(complaint['text'],style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
              ),
              Container(padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(width: 3,
                color:complaint['status']=="registered"?Colors.orange:Colors.green ),
                borderRadius: BorderRadius.circular(10)),
                child: Text(complaint['status'],style: TextStyle(fontWeight: FontWeight.bold,
                color: complaint['status']=="registered"?Colors.orange:Colors.green),))
            ],
          ),Divider(thickness: 3,color: Colors.grey,),
            Padding(padding: EdgeInsets.only(bottom: 10))
          ,
            Text('Category: '+complaint['category']),Padding(padding: EdgeInsets.only(bottom: 7)),
            Text(address),Padding(padding: EdgeInsets.only(bottom: 7)),
            Text('Registered on: '+date)
          ],),
        ),
        GestureDetector(onTap: (){handleDelete(complaint['_id']);},child: Container(alignment: AlignmentDirectional.center,height: 50,width: MediaQuery.of(context).size.width-20,padding: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(width: 3,
                color:Colors.red),
                borderRadius: BorderRadius.circular(10)),
                child: Text("Delete Complaint",style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.red,fontSize: 20),)),)],
    ),);
  }
}