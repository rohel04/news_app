import 'dart:convert';
import 'package:http/http.dart';
import 'package:news/news_model.dart';
import 'package:news/home.dart';
class News{

  Future<Map> getData() async
  {
    Uri uri=Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=025d05e980754132a1724b5d21d8edaf');
    Response response=await get(uri);
    Map data=jsonDecode(response.body);
    return data;

  }

}
