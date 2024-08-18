import 'package:Crime_and_Convenience/Services/newsService.dart';
import 'package:Crime_and_Convenience/Widgets/AppBarWidget.dart';
import 'package:Crime_and_Convenience/Widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var news;

  @override
  void initState() { 
    getNews();
    super.initState();
    
  }


  getNews(){
    NewsService().getNews().then((val){
      if (val!=null){
        setState(() {
          news=val.data['news'];
          
        });
      }
    });
  }

  showNewsList(){
    print(news);
    if (news==null){
      return circularProgress(context);
    }else if (news.isEmpty) return Text("");
    return ListView.builder(itemCount: news['articles'].length,itemBuilder: (context,index){
        String publishedAt=news['articles'][index]['publishedAt'];
        String date=publishedAt.substring(0,10);
        String time=publishedAt.substring(11,16);
        return GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: 
        (context)=>ShowNews(news['articles'][index])));},
                  child: Card(margin: EdgeInsets.all(5),
                    child: ListTile(leading: Container(width: 60,decoration: BoxDecoration(image: 
                    DecorationImage(image: NetworkImage(news['articles'][index]['urlToImage']))),),
            subtitle: Text(date+'  '+time),
            title: Text(news['articles'][index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        );
      });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(child: showNewsList(), onRefresh: ()async=>getNews()) ,
    );
  }
}



class ShowNews extends StatelessWidget {
  var news;
  ShowNews(this.news);

  @override
  Widget build(BuildContext context) {
    print(news);
    return Scaffold(
      appBar: AppBar(title: Text(news['source']['name']),),
      body: ListView(children: [Container(height:200 ,width: MediaQuery.of(context).size.width-14,decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(news['urlToImage']),fit: BoxFit.fill)
        ),),Padding(padding: EdgeInsets.only(bottom: 7)),Text(news['title'],
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),Padding(padding: EdgeInsets.only(bottom:8 ),),
        Text('by : '+news['author'],),Padding(padding: EdgeInsets.only(bottom: 5),),Text('Published at :'+news['publishedAt']),

        
        
           Padding(padding: EdgeInsets.only(bottom: 5),),Padding(
             padding: const EdgeInsets.all(5),
             child: Text(news['description']),
           ),InkWell(child: Text("Read full news",style: TextStyle(fontWeight: FontWeight.bold,
           color: Colors.blue,decoration: TextDecoration.underline),),onTap: () async{await launch(news['url']);},)
      ],),
    );
  }
}