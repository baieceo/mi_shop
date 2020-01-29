import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mi_shop/components/Gallery.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/utils/index.dart';

class Product extends StatefulWidget {
  final Map arguments;
  Product({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Product> {
  Map pageData = Map();
  Map goodsInfo = Map();
  bool loading = true;

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget topBar(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: new Container(
              margin: EdgeInsets.all(10),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: new IconButton(
                iconSize: 20,
                icon: Icon(Icons.arrow_back_ios),
                color: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    if (loading == false) {
      // 价格
      List<InlineSpan> productPrices = [];

      productPrices.add(new TextSpan(
        text: '￥' + goodsInfo['price'] + '  ',
        style: TextStyle(
          fontSize: 26,
          color: Color(0xffff6700),
        ),
      ));

      if (goodsInfo['market_price'] != null &&
          goodsInfo['price'] != goodsInfo['market_price']) {
        productPrices.add(new TextSpan(
          text: '￥' + goodsInfo['market_price'],
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 0, 0, .54),
            decoration: TextDecoration.lineThrough,
          ),
        ));
      }

      // 关键参数
      List<Widget> classParams = [];
      List classParamsList = [];

      if (goodsInfo['class_parameters']['list'] != null) {
        classParamsList = goodsInfo['class_parameters']['list']
            .where((item) => item['icon'] != null)
            .toList();

        classParamsList.forEach((param) {
          classParams.add(new Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: 100,
            child: new Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(param['icon']),
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                Container(
                  height: 20,
                  child: Text(
                    param['top_title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  param['bottom_title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ));
        });
      }

      // 为你推荐
      List<Widget> relatedRecommend = [];

      if (pageData['related_recommend'] != null &&
          pageData['related_recommend']['data'] != null) {
        pageData['related_recommend']['data'].forEach((item) {
          relatedRecommend.add(new Container(
            child: new GestureDetector(
              onTap: () {
                print('点击推荐');
              },
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xffcccccc),
                          width: .5,
                        )),
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: new Image(
                        width: 95,
                        height: 95,
                        image: NetworkImage(item['image_url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  new Container(
                    width: 95,
                    height: 30,
                    padding: EdgeInsets.only(top: 10),
                    child: new Center(
                      child: new Text(
                        item['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff3c3c3c),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  new Text(
                    '￥' +
                        item['price'] +
                        (item['is_multi_price'] == true ? '起' : ''),
                    style: TextStyle(
                      color: Color(0xffff6700),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
      }

      // 产品详情
      List<Widget> goodsTpl = [];

      int pageId = pageData['product_info']['page_id'];

      pageData['goods_tpl_datas'][pageId.toString()]['sections']
          .forEach((item) {
        if (item['view_type'] == 'image_w_1080') {
          goodsTpl.add(new Image(
            image: NetworkImage(handleUrl(item['body']['img_url'])),
            fit: BoxFit.contain,
          ));
        }

        /* if (item['view_type'] == 'blank_line') {
          goodsTpl.add(new Container(
            height: double.parse(item['body']['line_height']),
          ));
        } */
      });

      String productDesc = '';

      if (goodsInfo['product_desc'] != null &&
          goodsInfo['product_desc'] != '') {
        productDesc = goodsInfo['product_desc'];
      } else if (pageData['product_info'] != null &&
          pageData['product_info']['product_desc'] != null &&
          pageData['product_info']['product_desc'] != '') {
        productDesc = pageData['product_info']['product_desc'];
      }

      return new ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          // 顶部黑条
          new Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            height: MediaQuery.of(context).padding.top,
          ),
          // 轮播
          new Gallery(
            items: goodsInfo == null ? [] : goodsInfo['gallery_v3'],
            height: 450,
            space: 3.5,
            size: 5.0,
          ),
          // 产品名称
          new Container(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Text(
              pageData['product_info']['name'],
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff3c3c3c),
              ),
            ),
          ),
          // 产品说明
          new Container(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: new Html(
              data: productDesc,
              defaultTextStyle: TextStyle(
                color: Color.fromRGBO(0, 0, 0, .54),
                fontSize: 14,
              ),
            ),
          ),
          // 产品价格
          new Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 18),
            child: Text.rich(TextSpan(children: productPrices)),
          ),
          // 关键参数
          classParams.length == 0
              ? new Container()
              : new SizedBox(
                  height: 66,
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: classParams,
                  ),
                ),
          // 为你推荐
          relatedRecommend.length == 0
              ? new Container()
              : new Container(
                  height: 235,
                  margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                  decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    border: Border.all(
                      color: Color(0xffe5e5e5),
                      width: .5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xffe5e5e5),
                              width: .5,
                            ),
                          ),
                        ),
                        height: 46,
                        child: new Center(
                          child: new Text(
                            pageData['related_recommend']['title'],
                            style: TextStyle(
                              color: Color(0xffff6700),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: new SizedBox(
                          height: 150,
                          child: new ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              new Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: new Row(
                                  children: relatedRecommend,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          // 产品详情
          new Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: new Column(
              children: goodsTpl,
            ),
          )
        ],
      );
    } else {
      return new Center(
        child: Image(image: new AssetImage('images/placeholder.png')),
      );
    }
  }

  // 底部栏
  Widget actionBar(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      child: new Container(
        margin: EdgeInsets.all(10),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              // 0 2px 4px -1px rgba(0,0,0,.2)
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -1,
              color: Color.fromRGBO(0, 0, 0, .2),
            ),
            BoxShadow(
              // 0 4px 5px rgba(0,0,0,.14)
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, .14),
            ),
            BoxShadow(
              // 0 1px 10px rgba(0,0,0,.12)
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, .12),
            ),
          ],
        ),
        child: new Row(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: new GestureDetector(
                child: new Container(
                  width: 50,
                  child: new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Color.fromRGBO(0, 0, 0, .54),
                        ),
                        Text(
                          '首页',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, .54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ),
            Expanded(
              flex: 0,
              child: new GestureDetector(
                child: new Container(
                  width: 50,
                  child: new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          color: Color.fromRGBO(0, 0, 0, .54),
                        ),
                        Text(
                          '购物车',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, .54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print('点击首页');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 15),
                child: new FlatButton(
                  color: Color(0xffff6700),
                  highlightColor: Color(0xffff9700),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    '立即购买',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: mainBody(context),
          ),
          new Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: new Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0),
              ),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: topBar(context),
            ),
          ),
          new Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: actionBar(context),
          ),
        ],
      ),
    );
  }

  void requestAPI() async {
    var res = await Http.post(path: PRODUCT_VIEW, data: {
      'client_id': '180100031051',
      'channel_id': '',
      'webp': '1',
      'commodity_id': widget.arguments['product_id'],
      'pid': widget.arguments['product_id'],
    });

    setState(() {
      pageData = res;
      goodsInfo = pageData['goods_info'][0];
      loading = false;
    });
  }
}
