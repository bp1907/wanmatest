import 'package:flutter/material.dart';
import 'package:wanma_sample/page/login_page.dart';
import 'package:wanma_sample/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '万马集团',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      routes: {
        HomePage.sName: (context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}

