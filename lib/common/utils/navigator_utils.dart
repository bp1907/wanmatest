import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanma_sample/page/home_page.dart';

///导航栏
class NavigatorUtils {

  //主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
//  static NavigatorRouter(BuildContext context,Widget widget) {
//    return Navigator.push(context, CupertinoPageRoute(builder: (context) => widget));
//  }
}