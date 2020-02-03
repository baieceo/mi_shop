import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Page();
  }
}

class Page extends State<Login> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // 渲染头部
  Widget renderHeader(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(60), bottom: ScreenUtil().setWidth(20)),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
            child: new Image(
              image: NetworkImage(
                  'https://account.xiaomi.com/static/res/11eb7d1/account-static/respassport/acc-2014/img/2018/milogo.png'),
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(100),
              fit: BoxFit.contain,
            ),
          ),
          new Text(
            '小米账号登录',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(36),
            ),
          ),
        ],
      ),
    );
  }

  // 渲染表单
  Widget renderForm(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(36)),
      child: new Form(
        key: _formKey,
        // autovalidate: true,
        child: new Column(
          children: <Widget>[
            new TextFormField(
              autofocus: true,
              controller: _userNameController,
              decoration: InputDecoration(
                hintText: '手机号',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffff6666),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffd3d3d3),
                  ),
                ),
              ),
              validator: (v) {
                return v.trim().length > 0 ? null : '请输入手机号';
              },
            ),
            new TextFormField(
              autofocus: true,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '密码',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffff6666),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffd3d3d3),
                  ),
                ),
              ),
              validator: (v) {
                return v.trim().length > 0 ? null : '请输入密码';
              },
            ),
            new Container(
              width: double.infinity,
              height: ScreenUtil().setWidth(90),
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
              child: new FlatButton(
                color: Color(0xffff6700),
                highlightColor: Color(0xffff6600),
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text(
                  '立即登录/注册',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  if ((_formKey.currentState as FormState).validate()) {
                    print('验证通过');
                  }
                },
              ),
            ),
            new Container(
              width: double.infinity,
              height: ScreenUtil().setWidth(90),
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
              child: new OutlineButton(
                borderSide: BorderSide(color: Color(0xffd3d3d3)),
                highlightedBorderColor: Color(0xffd3d3d3),
                child: Text(
                  '返回',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget layout(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(40),
        right: ScreenUtil().setWidth(40),
        bottom: ScreenUtil().setWidth(40),
      ),
      child: new ListView(
        children: <Widget>[
          renderHeader(context),
          renderForm(context),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: layout(context),
      ),
    );
  }
}
