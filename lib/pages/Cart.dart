import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/HeaderNav.dart';
import 'package:mi_shop/components/RecommendList.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Cart> {
  List header = List();
  List recommendList = List();

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);

    return layout(context);
  }

  // 渲染头部
  Widget renderHeader(BuildContext context) {
    return new HeaderNav(
      height: 50,
      left: new Container(
        child: new IconButton(
          color: Color(0XFFCCCCCC),
          iconSize: 25.0,
          icon: Icon(Icons.arrow_back_ios),
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      content: new Container(
        alignment: Alignment.center,
        child: new Text(
          '购物车',
          style: TextStyle(
            color: Color(0xff666666),
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
      right: new Container(
        child: new IconButton(
          color: Color(0XFFCCCCCC),
          iconSize: 35.0,
          icon: Icon(Icons.search),
          splashColor: Colors.transparent,
          onPressed: () {
            print('搜索');
          },
        ),
      ),
    );
  }

  // 渲染主体
  Widget renderContent(BuildContext context) {
    return new Expanded(
      flex: 1,
      child: new Container(
        child: new ListView(
          padding: EdgeInsets.only(top: 0, bottom: 40),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // 登录
            new Container(
              height: ScreenUtil().setHeight(104),
              decoration: new BoxDecoration(color: Colors.white),
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(32),
                0,
                ScreenUtil().setSp(32),
                0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    '登陆后享受更多优惠',
                    style: TextStyle(
                        color: Color(0xff212121),
                        fontSize: ScreenUtil().setSp(32)),
                  ),
                  new Text(
                    '去登录 >',
                    style: TextStyle(
                        color: Color(0xff757575),
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                ],
              ),
            ),
            // 购物车
            new Container(
              height: ScreenUtil().setHeight(124),
              decoration: BoxDecoration(color: Color(0xffebebeb)),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: AssetImage('images/cart.png'),
                    width: ScreenUtil().setWidth(70),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: new Text(
                      '购物车还是空的',
                      style: TextStyle(
                        color: Color(0xffBABABA),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                  ),
                  new Container(
                    height: ScreenUtil().setSp(50),
                    width: ScreenUtil().setSp(136),
                    child: new MaterialButton(
                      color: Color(0xffebebeb),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xffD8D8D8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      elevation: 0,
                      child: new Text(
                        '去逛逛',
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: ScreenUtil().setSp(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 推荐
            RecommendList(
              referer: 'https://m.mi.com/cart',
            ),
          ],
        ),
      ),
    );
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new SafeArea(
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: new Column(
            children: <Widget>[
              renderHeader(context),
              renderContent(context),
            ],
          ),
        ),
      ),
    );
  }

  void requestAPI() async {}
}
