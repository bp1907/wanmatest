import 'package:flutter/material.dart';
import 'package:wanma_sample/page/login_page.dart';
import 'package:wanma_sample/page/home_page.dart';
import 'package:wanma_sample/common/redux/wm_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wanma_sample/common/model/User.dart';
import 'package:wanma_sample/common/utils/common_utils.dart';
import 'package:wanma_sample/common/style/wm_style.dart';
import 'package:wanma_sample/page/gfz/order_status.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  /// 创建Store，引用 WMState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = Store<WMState>(
    appReducer,
    ///初始化数据
    initialState: WMState(
      userInfo: User.empty(),
      themeData: CommonUtils.getThemeData(WMColors.primarySwatch),
    )
  );
  
  MyApp({Key key}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return StoreProvider(
        store: store,
        child: StoreBuilder<WMState>(
            builder: (context, store) {
              return MaterialApp(
                title: '万马集团',
                theme: store.state.themeData,
                routes: {
                  LoginPage.sName: (context) => LoginPage(),
                  HomePage.sName: (context) => HomePage(),
                  OrderStatus.sName: (context) => OrderStatus(),
                },
                home: LoginPage(),
              );
            }
        ),
    );
  }
}

