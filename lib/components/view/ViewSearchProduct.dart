import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class ViewSearchProduct extends StatelessWidget {
  final Map data;
  const ViewSearchProduct({Key key, this.data}) : super(key: key);

  Widget layout(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'product_id': json
                .decode(this.data['action']['extra'])['commodityId']
                .toString(),
          },
        );
      },
      child: new Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setWidth(30),
        ),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Image(
                image: NetworkImage(handleUrl(this.data['image'])),
                width: ScreenUtil().setWidth(260),
                height: ScreenUtil().setWidth(260),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(26),
                    left: ScreenUtil().setWidth(20)),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      this.data['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .87),
                        fontSize: ScreenUtil().setSp(32),
                      ),
                    ),
                    new LimitedBox(
                      maxHeight: ScreenUtil().setWidth(75),
                      child: new Html(
                        useRichText: false,
                        data: this.data['desc'],
                        defaultTextStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, .54),
                          fontSize: ScreenUtil().setSp(24),
                        ),
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(24)),
                      child: new Text.rich(
                        TextSpan(children: [
                          new TextSpan(
                            text: '￥' + this.data['price'] + ' ',
                            style: TextStyle(
                              color: Color(0xffff6700),
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                          this.data['market_price'] != null &&
                                  this.data['price'] !=
                                      this.data['market_price']
                              ? new TextSpan(
                                  text: '￥' + this.data['market_price'],
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color.fromRGBO(0, 0, 0, .54),
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                )
                              : new TextSpan(),
                        ]),
                      ),
                    ),
                    new Text(
                      this.data['comments_total'].toString() +
                          '条评价' +
                          ' ' +
                          this.data['satisfy_per'] +
                          '满意',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .54),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }
}
