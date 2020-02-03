import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/WhiteSpace.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Page();
  }
}

class Page extends State<Mine> {
  List menuConfig = [
    {
      'image': 'images/icon-vip.png',
      'label': '会员中心',
      'onTap': (item, snapshot) {
        print('会员中心');
      },
    },
    {
      'image': 'images/icon-coupon.png',
      'label': '我的优惠',
      'onTap': (item, snapshot) {
        print('我的优惠');
      },
    },
    {
      'image': 'images/icon-service.png',
      'label': '服务中心',
      'onTap': (item, snapshot) {
        print('服务中心');
      },
    },
    {
      'image': 'images/icon-home.png',
      'label': '小米之家',
      'onTap': (item, snapshot) {
        print('小米之家');
      },
    },
    {
      'image': 'images/icon-fcode.png',
      'label': '我的F码',
      'onTap': (item, snapshot) {
        print('我的F码');
      },
    },
    {
      'image': 'images/icon-gift.png',
      'label': '礼物码兑换',
      'onTap': (item, snapshot) {
        print('礼物码兑换');
      },
    },
    {
      'image': 'images/icon-gear.png',
      'label': '会员中心',
      'onTap': (item, snapshot) {
        print('设置');
      },
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  // 渲染头部
  Widget renderHeader(BuildContext context, AsyncSnapshot snapshot) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(36)),
      decoration: BoxDecoration(
        color: Color(0xfff37d0f),
        image: DecorationImage(
          image: AssetImage('images/mine-header-bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Row(
        children: <Widget>[
          // 头像
          new Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(36),
              right: ScreenUtil().setWidth(20),
            ),
            child: new Image(
              image: AssetImage('images/mine-avatar-default.png'),
              width: ScreenUtil().setWidth(110),
              height: ScreenUtil().setHeight(110),
            ),
          ),
          // 登录
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: new Text(
              '登录/注册',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(28),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 渲染订单
  Widget renderOrder(BuildContext context, AsyncSnapshot snapshot) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, .15),
                  width: .5,
                ),
              ),
            ),
            height: ScreenUtil().setWidth(80),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  '我的订单',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, .87),
                    fontSize: ScreenUtil().setSp(32),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    print('查看全部订单');
                  },
                  child: new Text(
                    '全部订单 >',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, .87),
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(80),
                vertical: ScreenUtil().setWidth(40)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // 待付款
                new GestureDetector(
                  onTap: () {
                    print('待付款');
                  },
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                        child: new Image(
                          image: AssetImage('images/icon-wallet.png'),
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setWidth(50),
                          fit: BoxFit.contain,
                        ),
                      ),
                      new Text(
                        '待付款',
                      ),
                    ],
                  ),
                ),
                // 待收货
                new GestureDetector(
                  onTap: () {
                    print('待收货');
                  },
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                        child: new Image(
                          image: AssetImage('images/icon-car.png'),
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setWidth(50),
                          fit: BoxFit.contain,
                        ),
                      ),
                      new Text(
                        '待收货',
                      ),
                    ],
                  ),
                ),
                // 退换修
                new GestureDetector(
                  onTap: () {
                    print('退换修');
                  },
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                        child: new Image(
                          image: AssetImage('images/icon-setting.png'),
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setWidth(50),
                          fit: BoxFit.contain,
                        ),
                      ),
                      new Text(
                        '退换修',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int menuIndex = 0;
  List<Widget> menuComponents = [];

  // 渲染菜单
  Widget renderMenu(BuildContext context, AsyncSnapshot snapshot) {
    menuConfig.forEach((item) {
      if (menuIndex % 2 == 0) {
        menuComponents.add(
          new WhiteSpace(
            size: ScreenUtil().setWidth(20),
            color: Color(0xfff5f5f5),
          ),
        );
      }

      menuComponents.add(new GestureDetector(
        onTap: () {
          item['onTap'](item, snapshot);
        },
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: new Row(
            children: <Widget>[
              new Container(
                width: ScreenUtil().setWidth(110),
                height: ScreenUtil().setWidth(110),
                child: new Center(
                  child: new Image(
                    image: AssetImage(item['image']),
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
                  height: ScreenUtil().setWidth(110),
                  decoration: BoxDecoration(
                    border: menuIndex % 2 == 0
                        ? null
                        : Border(
                            top: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, .15),
                              width: .5,
                            ),
                          ),
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        item['label'],
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          color: Color.fromRGBO(0, 0, 0, .87),
                        ),
                      ),
                      new Icon(
                        Icons.chevron_right,
                        color: Color.fromRGBO(0, 0, 0, .54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      menuIndex++;
    });

    return new Container(
      child: new Column(
        children: menuComponents,
      ),
    );
  }

  Widget layout(BuildContext context, AsyncSnapshot snapshot) {
    return new Container(
      child: new ListView(
        children: <Widget>[
          renderHeader(context, snapshot),
          renderOrder(context, snapshot),
          renderMenu(context, snapshot),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new FutureBuilder(
          future: _getData(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return layout(context, snapshot);
            } else {
              return new Container();
            }
          },
        ),
      ),
    );
  }

  Future<Map> _getData(BuildContext context) async {
    return Map();
  }
}
