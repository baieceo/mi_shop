import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class ListTwoType13 extends StatefulWidget {
  final Map data;
  ListTwoType13({Key key, this.data}) : super(key: key);

  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListTwoType13> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 8.0),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Color(handleColor(widget.data['bg_color'])),
      ),
      child: new Row(
        children: handlerData(),
      ),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];
    double itemWidth = ScreenUtil().setWidth(338);

    if (widget.data['items'] != null) {
      widget.data['items'].forEach((item) {
        items.add(
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/product',
                arguments: {
                  'product_id': item['product_id'],
                },
              );
            },
            child: new Container(
              margin: EdgeInsets.only(right: 8.0),
              child: new Column(
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Image(
                        image: NetworkImage(handleUrl(item['img_url'])),
                        fit: BoxFit.cover,
                        width: itemWidth,
                        height: ScreenUtil().setWidth(270),
                      ),
                      item['product_tag_array'] != null &&
                              item['product_tag_array'].length > 0
                          ? new Positioned(
                              right: 5,
                              bottom: 5,
                              child: new Image(
                                image: NetworkImage(
                                    handleUrl(item['product_tag_array'][0])),
                                fit: BoxFit.contain,
                                width: 50,
                                height: 50,
                              ),
                            )
                          : new Container()
                    ],
                  ),
                  new Container(
                    width: itemWidth,
                    child: new Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            item['product_name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: ScreenUtil().setSp(26),
                              color: Color.fromRGBO(0, 0, 0, .87),
                            ),
                          ),
                          new Text(
                            item['product_brief'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: ScreenUtil().setSp(20),
                              color: Color.fromRGBO(0, 0, 0, .54),
                            ),
                          ),
                          new Text.rich(
                            new TextSpan(children: [
                              new TextSpan(
                                text: '￥' + item['product_price'],
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(26),
                                  color: Color(
                                      handleColor(widget.data['btn_color'])),
                                ),
                              ),
                              new TextSpan(
                                text:
                                    item['show_price_qi'] == true ? '起 ' : ' ',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  color: Color(
                                      handleColor(widget.data['btn_color'])),
                                ),
                              ),
                              item['product_price'] != item['product_org_price']
                                  ? new TextSpan(
                                      text: '￥' + item['product_org_price'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, .54),
                                        fontSize: ScreenUtil().setSp(20),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  : new TextSpan(),
                            ]),
                          ),
                          new FlatButton(
                            child: new Text('立即购买'),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            color: Color(handleColor(widget.data['btn_color'])),
                            textColor: Color(
                                handleColor(widget.data['btn_txt_color'])),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/product',
                                arguments: {
                                  'product_id': item['product_id'],
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    }

    return items;
  }
}
