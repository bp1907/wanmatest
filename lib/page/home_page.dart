import 'package:flutter/material.dart';
import 'package:wanma_sample/common/utils/common_utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wanma_sample/common/redux/wm_state.dart';
import 'package:wanma_sample/common/utils/navigator_utils.dart';

///主页

class HomePage extends StatefulWidget {
  static final String sName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController tabController;

  /// 提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('确定要退出应用？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消')
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('确定')
            ),
          ],
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = [
      _renderTab(Icons.store, '工业4.0'),
      _renderTab(Icons.business, '业务'),
      _renderTab(Icons.devices_other, '其他'),
    ];
    return WillPopScope(
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('万马集团'),
        ),
        body: TabBarView(
          children: <Widget>[
            FactorPage(),//工业4.0
            BusinessPage(),//业务
            OtherPage(),//其他
          ],
          controller: tabController,
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: tabs,
            controller: tabController,
            indicatorColor: Colors.white,
          ),
        ),
      ),
      onWillPop: () => _dialogExitApp(context),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }
}

//单个底部菜单
_renderTab(icon, text, {size, color}) {
  return Tab(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(icon, size: size,color: color,), Text(text,style: TextStyle(fontWeight: FontWeight.bold),)],
    ),
  );
}

class HomeDrawer extends StatelessWidget {

  //关于
  showAboutDialog(BuildContext context, String versionName) {
    versionName ??= 'null';
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('当前版本：$versionName'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('确定'),),
        ],
      ),
    );
  }

  //主题切换
  showThemeDialog(BuildContext context,Store store) {
    List<String> listStr = [
      '默认主题',
      '主题一',
      '主题二',
      '主题三',
      '主题四',
      '主题五',
      '主题六',
    ];
    List<Color> listColor = CommonUtils.getThemeListColor();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 250.0,
            height: 400.0,
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: ListView.builder(
              itemCount: listStr.length,
              itemBuilder: (context,index) {
                return RaisedButton(
                  padding: new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                  textColor: Colors.white,
                  color: listColor != null ? listColor[index] : Theme.of(context).primaryColor,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.start,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(listStr[index],style: TextStyle(fontSize: 14.0,),maxLines: 2,),
                    ],
                    ),
                  onPressed: (){
                    Navigator.pop(context);
                    CommonUtils.pushTheme(store, index);
                  },
                );
              },
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreBuilder<WMState>(
          builder: (context,store){
            return Drawer(
              //侧边栏按钮
              child: Container(
                color: Theme.of(context).primaryColor,
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Material(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          UserAccountsDrawerHeader(
                            accountName: Text('王振',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                            currentAccountPicture: GestureDetector(
                              onTap: (){},
                              child: CircleAvatar(
                                backgroundImage: AssetImage('images/logo.png'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          ListTile(
                            title: Text('设置参数'),
                            onTap: (){
                              //TODO
                            },
                          ),
                          ListTile(
                            title: Text('修改密码'),
                            onTap: (){
                              //TODO
                            },
                          ),
                          ListTile(
                            title: Text('切换主题'),
                            onTap: (){
                              showThemeDialog(context,store);
                            },
                          ),
                          ListTile(
                            title: Text('问题反馈'),
                            onTap: (){
                              //TODO
                            },
                          ),
                          ListTile(
                            title: Text('检测更新'),
                            onTap: (){
                              //TODO
                            },
                          ),
                          ListTile(
                            title: RaisedButton(
                              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                              textColor: Colors.white,
                              color: Colors.redAccent,
                              child: Flex(
                                mainAxisAlignment: MainAxisAlignment.center,
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Text('退出登录',style: TextStyle(fontSize: 20.0),maxLines: 1,),
                                ],
                              ),
                              onPressed: (){
                                NavigatorUtils.goLogin(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}


//工业4.0页面
class FactorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 30.0,
      crossAxisCount: 3,
      children: <Widget>[
        _renderTab(Icons.line_style, '生产线列表',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.linear_scale, '历史运行曲线',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.linear_scale, '生产线运行日志',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.devices, '异常查询',size: 32.0,color: Colors.deepOrange),
      ],
    );
  }
}

//业务页面
class BusinessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 30.0,
      crossAxisCount: 3,
      children: <Widget>[
        InkWell(
          child: _renderTab(Icons.store, '订单状态',size: 32.0,color: Colors.deepOrange),
          onTap: (){
            NavigatorUtils.goGfzOrderStatus(context);
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('暂未开通')));
          },
        ),

        _renderTab(Icons.store, '应收货款',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '货款回笼',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '开票情况',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '基准价',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '目标情况',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '发出情况',size: 32.0,color: Colors.deepOrange),
        _renderTab(Icons.store, '发货跟踪',size: 32.0,color: Colors.deepOrange),
      ],
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('其他'),
    );
  }
}