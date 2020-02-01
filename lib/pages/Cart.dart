import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/HeaderNav.dart';
import 'package:mi_shop/components/RecommendList.dart';
import 'package:mi_shop/provider/cart.dart';
import 'package:mi_shop/utils/index.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Cart> {
  List header = List();
  List recommendList = List();
  List<Widget> cartList = [];

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
            Navigator.pushNamed(context, '/search');
          },
        ),
      ),
    );
  }

  // 渲染购物车
  Widget renderCartList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null &&
        snapshot.data.length != null &&
        snapshot.data.length != 0) {
      cartList = [];

      snapshot.data.forEach((item) {
        item = item.toJson();

        cartList.add(new Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffeeeeee),
                    width: .5,
                  ),
                ),
                // 图片
                child: new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product',
                      arguments: {
                        'product_id': item['goodsId'].toString(),
                      },
                    );
                  },
                  child: new FadeInImage.assetNetwork(
                    placeholder: 'images/placeholder.png',
                    image: handleUrl(item['images']),
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setWidth(200),
                  ),
                ),
              ),
              // 主体
              new Expanded(
                flex: 1,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
                      child: new Text(item['goodsName'].toString(),
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    new Container(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
                      child: new Text('售价：' + item['price'].toString() + ' 元',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: ScreenUtil().setSp(24),
                          )),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Container(
                              width: ScreenUtil().setWidth(60),
                              height: ScreenUtil().setWidth(60),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff999999),
                                  width: .5,
                                ),
                              ),
                              child: new Center(
                                child: new IconButton(
                                  icon: new Icon(Icons.remove),
                                  iconSize: ScreenUtil().setWidth(30),
                                  disabledColor: Color(0xff999999),
                                  onPressed: () async {
                                    if (item['count'] <= 1) {
                                      return null;
                                    } else {
                                      await Provider.of<CartProvider>(context)
                                          .save(
                                        item['goodsId'].toString(),
                                        item['goodsName'],
                                        -1,
                                        item['price'],
                                        item['images'],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            new Container(
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setWidth(60),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xff999999),
                                    width: .5,
                                  ),
                                  bottom: BorderSide(
                                    color: Color(0xff999999),
                                    width: .5,
                                  ),
                                ),
                              ),
                              child: new Center(
                                child: new Text(item['count'].toString()),
                              ),
                            ),
                            new Container(
                              width: ScreenUtil().setWidth(60),
                              height: ScreenUtil().setWidth(60),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff999999),
                                  width: .5,
                                ),
                              ),
                              child: new Center(
                                child: new IconButton(
                                  icon: new Icon(Icons.add),
                                  iconSize: ScreenUtil().setWidth(30),
                                  onPressed: () async {
                                    await Provider.of<CartProvider>(context)
                                        .save(
                                      item['goodsId'].toString(),
                                      item['goodsName'],
                                      1,
                                      item['price'],
                                      item['images'],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 删除按钮
                        new IconButton(
                          icon: Icon(Icons.delete_outline),
                          color: Color(0xff999999),
                          onPressed: () async {
                            Provider.of<CartProvider>(context)
                                .remove(item['goodsId']);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      });

      return new Container(
        child: new Column(
          children: cartList,
        ),
      );
    } else {
      return // 购物车
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
      );
    }
  }

  // 渲染主体
  Widget renderContent(BuildContext context, AsyncSnapshot snapshot) {
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
            // 渲染购物车
            renderCartList(context, snapshot),
            // 推荐
            RecommendList(
              referer: 'https://m.mi.com/cart',
            ),
          ],
        ),
      ),
    );
  }

  // 渲染底部
  Widget renderFooter(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null &&
        snapshot.data.length != null &&
        snapshot.data.length > 0) {
      return new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            //卡片阴影
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .2),
              offset: Offset(0, -2.0),
              blurRadius: 4.0,
              spreadRadius: -1,
            ),
          ],
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: new Column(
                  children: <Widget>[
                    new FutureBuilder(
                      future: _getCartCount(context),
                      builder: (context, snap) {
                        return new Text(
                          '共' + snap.data.toString() + '件 金额：',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: ScreenUtil().setSp(24),
                          ),
                        );
                      },
                    ),
                    new FutureBuilder(
                      future: _getCartTotalPrice(context),
                      builder: (context, snap) {
                        return new Text.rich(
                          TextSpan(
                            children: [
                              new TextSpan(
                                text: snap.data.toString(),
                                style: TextStyle(
                                  color: Color(0xffff5722),
                                  fontSize: ScreenUtil().setSp(32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              new TextSpan(
                                text: ' 元',
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              width: ScreenUtil().setWidth(230),
              height: ScreenUtil().setWidth(100),
              child: new FlatButton(
                child: Text(
                  '继续购物',
                  style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                ),
                color: Color(0xfff4f4f4),
                textColor: Color(0xff333333),
                onPressed: () {
                  Navigator.pushNamed(context, '/category');
                },
              ),
            ),
            new SizedBox(
              width: ScreenUtil().setWidth(230),
              height: ScreenUtil().setWidth(100),
              child: new FlatButton(
                child: Text(
                  '去结算',
                  style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                ),
                color: Color(0xffff6700),
                textColor: Color(0xffffffff),
                onPressed: () {
                  print('去结算');
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            return new SafeArea(
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: new Column(
                  children: <Widget>[
                    renderHeader(context),
                    renderContent(context, snapshot),
                    renderFooter(context, snapshot),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void requestAPI() async {}

  Future<List> _getCartInfo(context) async {
    return await Provider.of<CartProvider>(context).getCartInfo();
  }

  Future<int> _getCartCount(context) async {
    return await Provider.of<CartProvider>(context).getCartCount();
  }

  Future<double> _getCartTotalPrice(context) async {
    return await Provider.of<CartProvider>(context).getCartTotalPrice();
  }
}
