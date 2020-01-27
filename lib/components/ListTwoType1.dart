import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTwoType1 extends StatefulWidget {
  final Map data;
  ListTwoType1({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListTwoType1> {
  @override
  Widget build(BuildContext context) {
    var bgColor = 0xffffffff;
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Color(bgColor),
      ),
      child: Row(
        children: handlerData(),
      ),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];
    double itemWidth = ScreenUtil().setWidth(338);

    if (widget.data['items'] != null) {
      widget.data['items'].forEach((item) {
        List<Widget> imgs = [];
        String imgUrl = item['img_url'];

        RegExp isUri = new RegExp(r'^\/\/');

        if (isUri.hasMatch(imgUrl)) {
          imgUrl = 'https:' + imgUrl;
        }

        imgs.add(Image(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
          width: itemWidth,
          height: itemWidth,
        ));

        if (item['product_tag_array'] != null &&
            item['product_tag_array'].length > 0) {
          String tagUrl = item['product_tag_array'][0];

          if (isUri.hasMatch(tagUrl)) {
            tagUrl = 'https:' + tagUrl;
          }

          imgs.add(Positioned(
            right: 5,
            bottom: 5,
            child: Image(
              image: NetworkImage(tagUrl),
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ));
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

        items.add(
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: imgs,
                  ),
                  Container(
                    width: itemWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            item['product_name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: ScreenUtil().setSp(26),
                              color: Color.fromRGBO(0, 0, 0, .87),
                            ),
                          ),
                          Text(
                            item['product_brief'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: ScreenUtil().setSp(20),
                              color: Color.fromRGBO(0, 0, 0, .54),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: prices,
                            ),
                          ),
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
