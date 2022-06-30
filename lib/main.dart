import 'package:flutter/material.dart';
import 'package:news/loading.dart';
import 'package:news/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>Loading(),
      '/home':(context)=>Home()
    },
  ));
}



