import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import '../Services/updatesService.dart';

class Updates extends StatefulWidget {
  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  var updates;
  @override
  void initState() { 
    super.initState();
    getUpdates();
  }

  getUpdates(){
    UpdateService().getUpdates().then((val){
      if (val!=null){
        setState(() {
          updates=val.data;

        });
      }
    });
  }

  showUpdatesList(){
    print(updates);
    if (updates==null){
      return circularProgress(context);
    }else if (updates['count']==0) return Center(child: Text("No Updates",style: TextStyle(fontSize: 25,color: 
    Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),);
    return ListView.builder(itemCount: updates['count'],itemBuilder: (context,index){
        String datetime=updates['updates'][index]['date'];
        String date=datetime.substring(0,10);
        String time=datetime.substring(11,16);
        return Card(margin: EdgeInsets.all(5),
                    child: ListTile(
            trailing: Text(date),
            subtitle: Text(updates['updates'][index]['text']),
            title: Text(updates['updates'][index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),),
          );
    }   
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(child: showUpdatesList(), onRefresh: ()async=>getUpdates())
    );
  }
}


