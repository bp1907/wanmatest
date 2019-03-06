import 'package:flutter/material.dart';
import 'package:wanma_sample/common/local/local_storage.dart';
import 'package:wanma_sample/common/config/config.dart';
import 'package:wanma_sample/common/utils/navigator_utils.dart';

class LoginPage extends StatefulWidget {

  static final String sName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _userName = '';
  var _password = '';

  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  _LoginPageState() : super();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);

    userController.value = TextEditingValue(text: _userName ?? '');
    pwController.value = TextEditingValue(text: _password ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          //防止overflow的现象
          child: SafeArea(
            child: SingleChildScrollView(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Colors.white,
                margin: const EdgeInsets.only(left: 30.0,right: 30.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0,top: 40.0,right: 30.0,bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('images/logo.png',width: 90,height: 90,),
                      Padding(padding: EdgeInsets.all(10.0)),
                      TextField(
                        decoration: InputDecoration(
                          hintText:'请输入用户名',
                          icon: Icon(Icons.account_circle),
                        ),
                        onChanged: (String value){
                          _userName = value;
                        },
                        controller: userController,
                      ),
                      Padding(padding: new EdgeInsets.all(10.0)),
                      TextField(
                        decoration: InputDecoration(
                          hintText:'请输入密码',
                          icon: Icon(Icons.lock),
                        ),
                        onChanged: (String value){
                          _password = value;
                        },
                        controller: pwController,
                      ),
                      Padding(padding: new EdgeInsets.all(30.0)),
                      RaisedButton(
                        padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text('登录',style: TextStyle(fontSize: 20.0),maxLines: 1,),
                          ],
                        ),
                        onPressed: (){
                          NavigatorUtils.goHome(context);
                        },
                      ),
                      Padding(padding: new EdgeInsets.all(30.0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

