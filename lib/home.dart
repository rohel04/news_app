import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_2/news_model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  List<NewsModelQuery> newsModelList=<NewsModelQuery>[];
  List<NewsModelQuery> newsModelProvider=<NewsModelQuery>[];

  bool loading=true;
  getNewsQuery() async{
    String url='https://newsapi.org/v2/top-headlines?country=in&apiKey=025d05e980754132a1724b5d21d8edaf';
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
      data['articles'].forEach((element){
        NewsModelQuery newsModelQuery=NewsModelQuery();
        newsModelQuery=NewsModelQuery.fromMap(element);
    setState((){
        newsModelList.add(newsModelQuery);
      });
    });

  }
  getNewsByProvider() async{
    String url='https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=025d05e980754132a1724b5d21d8edaf';
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    data['articles'].forEach((element){
      NewsModelQuery newsModelQuery=NewsModelQuery();
      newsModelQuery=NewsModelQuery.fromMap(element);
    setState((){
      newsModelProvider.add(newsModelQuery);
    });
    });

  }

  getNewsByQuery(String query) async{
    String url='https://newsapi.org/v2/everything?q=$query&apiKey=025d05e980754132a1724b5d21d8edaf';
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    data['articles'].forEach((element){
      NewsModelQuery newsModelQuery=NewsModelQuery();
      newsModelQuery=NewsModelQuery.fromMap(element);
    setState((){
      newsModelList.add(newsModelQuery);
    });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsQuery();
    getNewsByProvider();
  }


  final _searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var categories=['Sports','Health','Politics','Education','Bitcoin','Economy'];
    List<String> navItems=['Sports','Nepal','Economy','Health'];
    var index=Random().nextInt(categories.length);
    var display=categories[index];





    return Scaffold(
      appBar: AppBar(
        title: Text('News Today'),

        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(margin:EdgeInsets.fromLTRB(10, 5, 10, 5),child: Icon(Icons.search)),
                    ),
                    Expanded(child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value){
                          _searchController.text='';
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search $display"
                      ),

                    ))
                  ],
                ),
              ),
              Container(
                height: 35,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemCount: navItems.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          newsModelList.clear();
                          getNewsByQuery(navItems[index]);
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text('${navItems[index]}',style: TextStyle(fontSize: 16,color: Colors.white),),
                        ),
                      );
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('BBC',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),

                )]),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                  items: newsModelProvider.map((news){
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),

                        child:
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:Image.network('${news.img}',fit: BoxFit.fitHeight,height: double.infinity,),
                            ),
                            Positioned(
                                left:0,
                                right:0,
                                bottom:0,
                                child: Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black
                                            ]
                                        )
                                    ),
                                    padding:EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child:
                                Column(

                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                Text('${news.newshead}',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                Text('${news.newsdesc.length>40? "${news.newsdesc.substring(0,40)}...": "${news.newsdesc}"}',style: TextStyle(color:Colors.white)),

                                ],
                                )

                            ))
                          ],
                        )


                      ),
                    );
                  }).toList(),
              ),
              
              Container(

                child:
                Column(
                  children: [
                    Container(
                      margin:EdgeInsets.symmetric(vertical:10,horizontal:15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                            Text('Latest News',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ]
              )
      ),


                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (contex,index){
                          return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child:Image.network('${newsModelList[index].img}'),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  Positioned(
                                      left:0,
                                      right:0,
                                      bottom:0,
                                      child: Container(
                                        decoration:BoxDecoration(
                                            borderRadius:BorderRadius.circular(15),
                                            gradient: LinearGradient(
                                                colors: [Colors.black12.withOpacity(0),
                                                  Colors.black
                                                ]
                                            )
                                        ),
                                        child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children:[Text('${newsModelList[index].newshead}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                              Text('${newsModelList[index].newsdesc.length > 50 ? "${newsModelList[index].newsdesc.substring(0,55)}...":"${newsModelList[index].newsdesc}" }',style: TextStyle(color: Colors.white))]),
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                      )
                                  ),

                                ],
                              ));
                        }),
                  ],
                )

              )
            ],
          ),
        ),
      )
    );

  }


}
