import 'package:flutter/material.dart';
import 'package:wanma_sample/common/model/User.dart';
import 'package:wanma_sample/common/redux/user_reducer.dart';
import 'package:wanma_sample/common/redux/theme_data_reducer.dart';

///Redux全局State store的对象，保存state数据
class WMState {
  //用户信息
  User userInfo;
  //主题数据
  ThemeData themeData;
  //构造方法
  WMState({this.userInfo,this.themeData});
}

//创建reducer
//自定义reducer用于创建store
WMState appReducer(WMState state, action) {
  return WMState(
    //通过UserReducer将WMState内的userInfo和action关联一起
    userInfo: userReducer(state.userInfo,action),
    themeData: themeDataReducer(state.themeData,action),
  );
}