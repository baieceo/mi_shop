import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTwoType2 extends StatefulWidget {
  final Map data;
  ListTwoType2({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListTwoType2> {
  @override
  Widget build(BuildContext context) {
    List<Widget> components = [];

    if (widget.data != null &&
        widget.data['items'] != null &&
        widget.data['items'].length > 0) {
      widget.data['items'].forEach((item) {
        var w = ScreenUtil().setWidth(360);

        RegExp isUri = new RegExp(r'^\/\/');

        if (isUri.hasMatch(item['img_url'])) {
          item['img_url'] = 'https:' + item['img_url'];
        }

        List<InlineSpan> prices = List();

        prices.add(TextSpan(
            text: '￥' + item['product_price'],
            style: TextStyle(
              fontSize: ScreenUtil().setSp(26),
              color: Color(0xffea625b),
            )));

        if (item['product_price'] != item['product_org_price']) {
          prices.add(TextSpan(
            text: '￥' + item['product_org_price'],
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, .54),
              fontSize: ScreenUtil().setSp(20),
              decoration: TextDecoration.lineThrough,
            ),
          ));
        }

        components.add(
          GestureDetector(
            child: Image(
              image: NetworkImage(item['img_url']),
              width: w,
            ),
            onTap: () {},
          ),
        );

        components.add(
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(305),
                    child: Text(
                      item['product_name'],
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .87),
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(305),
                    child: Text(
                      item['product_brief'],
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .54),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: ScreenUtil().setWidth(305),
                    child: Text.rich(TextSpan(
                      children: prices,
                    )),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
        );
      });

      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: components,
        ),
      );
    } else {
      return Container();
    }
  }
}
