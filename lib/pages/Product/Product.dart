import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/Gallery.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/utils/index.dart';

class Product extends StatefulWidget {
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
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.all(10),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.arrow_back_ios
                color: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  print('点击返回');
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget mainBody(BuildContext context) {
    if (loading == false) {
      // 价格
      List<InlineSpan> productPrices = [];

      productPrices.add(new TextSpan
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

      // 为你推荐
      List<Widget> relatedRecommend = [];

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
                        width: 1,
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

      return new ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
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
              data: goodsInfo['product_desc'],
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
          new SizedBox(
            height: 66,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: classParams,
            ),
          ),
          // 为你推荐
          new Container(
            height: 235,
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            decoration: BoxDecoration(
              color: Color(0xfffafafa),
              border: Border.all(color: Color(0xffe5e5e5), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: new Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffe5e5e5),
                        width: 1,
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

  Widget layout(BuildContext context) {
    print(MediaQuery.of(context).padding.top);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: mainBody(context),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0),
                  ),
                  padding:
                      EdgeInsets.only(top: Meimport 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/Gallery.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/utils/index.dart';

class Product extends StatefulWidget {
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
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.all(10),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.arrow_back_ios),
                color: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  print('点击返回');
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

      // 为你推荐
      List<Widget> relatedRecommend = [];

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

      return new ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
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
              data: goodsInfo['product_desc'],
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
          new SizedBox(
            height: 66,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: classParams,
            ),
          ),
          // 为你推荐
          new Container(
            height: 235,
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            decoration: BoxDecoration(
              color: Color(0xfffafafa),
              border: Border.all(color: Color(0xffe5e5e5), width: .5),
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

  Widget layout(BuildContext context) {
    print(MediaQuery.of(context).padding.top);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: mainBody(context),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0),
                  ),
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: topBar(context),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Text('尾'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void requestAPI() async {
    var res = await Http.post(path: PRODUCT_VIEW, data: {
      'client_id': '180100031051',
      'channel_id': '',
      'webp': '1',
      'commodity_id': '10000180',
      'pid': '10000180',
    });

    setState(() {
      pageData = res;
      goodsInfo = pageData['goods_info'][0];
      loading = false;
    });
  }
}
