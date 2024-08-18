import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import '../Services/boloService.dart';

class Bolo extends StatefulWidget {
  @override
  _BoloState createState() => _BoloState();
}

class _BoloState extends State<Bolo> {
  var bolo;
  @override
  void initState() { 
    getBolo();
    super.initState();
  }

  getBolo(){
    BoloService().getBolo().then((val){
      if (val!=null){
        print(val.data);
        setState(() {
          bolo=val.data;
        });
      }
    });
  }

  showBoloList(){
    
    if (bolo==null){
      return circularProgress(context);
    }else if (bolo['count']==0) return Center(child: Text("Nobody to Look for :)",style: TextStyle(fontSize: 25,color: 
    Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),);
    return ListView.builder(itemCount: bolo['count'],itemBuilder: (context,index){
        var imageUrl='https://cnc-project.herokuapp.com/'+bolo['bolos'][index]['image'];
        return Card(margin: EdgeInsets.all(5),
                    child: ListTile(onTap: (){Navigator.push(context, MaterialPageRoute(builder: 
                    (context)=>ShowBolo(bolo['bolos'][index])));},
                    leading: Container(width: 60,decoration: BoxDecoration(image: 
                    DecorationImage(image: NetworkImage(imageUrl))),),
            subtitle: Text(bolo['bolos'][index]['text']),
            title: Text(bolo['bolos'][index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),),
          );
    }   
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(child: showBoloList(), onRefresh: ()async=>getBolo())
    );
  }
}



class ShowBolo extends StatelessWidget {
  var bolo;
  ShowBolo(this.bolo);
  
  @override
  Widget build(BuildContext context) {
    var imageUrl='https://cnc-project.herokuapp.com/'+bolo['image'];
    return Scaffold(
      appBar: AppBar(title: Text(bolo['title'])),
      body: Container(
        child: ListView(padding: EdgeInsets.all(5),shrinkWrap: true,children: [Text(bolo['title'],style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,
                      fontSize: 35),textAlign: TextAlign.center,),
          Container(height: MediaQuery.of(context).size.height*0.7,decoration: BoxDecoration(image: 
                      DecorationImage(image: NetworkImage(imageUrl))),),
            //Expanded(child: Image.network(imageUrl)),
                      Divider(thickness: 2,color: Colors.green,),
                      Text(bolo['text'],textAlign: TextAlign.center,)
        ],),
      ),
    );
  }
}