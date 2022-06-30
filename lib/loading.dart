import 'package:flutter/material.dart';
import 'package:news/services/news.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getNewsData() async
  {
    News obj=News();
    Map data=await obj.getData();
    Navigator.pushReplacementNamed(context, '/home',arguments: data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
        ),
      )
    );
  }
}
