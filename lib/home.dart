import 'package:flutter/material.dart';
import 'package:news/services/news.dart';
import 'package:news/news_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<News_Model> news=[];
  Widget NewsCard(News_Model news)
  {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network('${news.img}',height: 200),
            SizedBox(height: 10.0),
            Text('${news.title}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,fontFamily: 'Abel'),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('- ${news.author}',style: TextStyle(fontSize: 11,color: Colors.redAccent),)
              ],
            )
            
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Map data=ModalRoute.of(context)!.settings.arguments as Map;
    for(int i=0;i<data['articles'].length;i++)
      {
        if(data['articles'][i]['urlToImage']==null) {
          news.add(News_Model(author: data['articles'][i]['author'],
              title: data['articles'][i]['title'],
              img: 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png'));
        }
        else
          {
              news.add(News_Model(author: data['articles'][i]['author'],
                  title: data['articles'][i]['title'],
                  img: data['articles'][i]['urlToImage']));
          }
      }

    return Scaffold(
      backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('News'),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.black87,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: [
                Text('Work in Progress !!',style: TextStyle(color: Colors.amberAccent[200]),),
              ],
            ),
          )
        ),

        body:

        SingleChildScrollView(

            child: Column(

              children: [
                Column(
                  children: news.map((n) => NewsCard(n)).toList()
                )
              ],
            )
        )
    );
  }
}