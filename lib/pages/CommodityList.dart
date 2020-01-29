import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/utils/index.dart';

class CommodityList extends StatefulWidget {
  final Map arguments;
  CommodityList({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<CommodityList> {
  List pageData = List();
  List listData = List();
  ScrollController _scrollController = new ScrollController();

  // 分类选择索引

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  @override
  void dispose() {
    // 避免内存泄露，调用 _scrollController.dispose
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  // 布局
  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new SafeArea(
        child: new Column(
          children: <Widget>[
            new Expanded(
              flex: 0,
              child: navBar(context),
            ),
            new Expanded(
              flex: 1,
              child: new Row(
                children: <Widget>[
                  // 主体
                  new Expanded(
                    flex: 3,
                    child: mainBody(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 导航栏
  Widget navBar(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        color: Color.fromRGBO(242, 242, 242, 1),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: IconButton(
              color: Color(0XFFCCCCCC),
              iconSize: 25.0,
              icon: Icon(Icons.arrow_back_ios),
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '商品列表',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Color(0XFF666666),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              color: Color(0XFFCCCCCC),
              iconSize: 35.0,
              icon: Icon(Icons.search),
              splashColor: Colors.transparent,
              onPressed: () {
                print('搜索');
              },
            ),
          ),
        ],
      ),
    );
  }

  // 主体
  Widget mainBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: listRender(context),
      ),
    );
  }

  // 商品列表
  List<Widget> listRender(BuildContext context) {
    List<Widget> list = [];

    listData.forEach((item) {
      list.add(new Container(
        child: new GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/product',
              arguments: {
                'product_id': item['product_id'].toString(),
              },
            );
          },
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 0,
                child: new Container(
                  width: 172,
                  height: 172,
                  child: new FadeInImage.assetNetwork(
                    placeholder: 'images/placeholder.png',
                    image: handleUrl(item['img_url']),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: new Text(
                          item['name'],
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, .87),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: new ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 38.0, //最小高度为50像素
                          ),
                          child: new Html(
                            useRichText: false,
                            data: item['product_desc'],
                            defaultTextStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, .54),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: new Text(
                          '￥' + item['price'],
                          style: TextStyle(
                            color: Color(0xffff6000),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });

    return list;
  }

  void requestAPI() async {
    var res = await Http.post(path: COMMODITY_LIST, data: {
      'client_id': '180100031051',
      'channel_id': '',
      'webp': '1',
      'category_id': widget.arguments['id'].toString(),
      'page_index': '1',
      'page_size': '20',
    });

    setState(() {
      listData = res['list'];
    });
  }
}
