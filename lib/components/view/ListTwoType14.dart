import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class ListTwoType14 extends StatefulWidget {
  final Map data;
  ListTwoType14({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListTwoType14> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Color(handleColor(widget.data['bg_color'])),
      ),
      child: new GridView(
        shrinkWrap: true, // 解决 ListView 和 GridView 混合使用报错问题
        physics:
            new NeverScrollableScrollPhysics(), // 解决 ListView 和 GridView 混合使用滚动冲突问题
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 30,
          childAspectRatio: 195 / 340,
        ),
        padding: EdgeInsets.symmetric(horizontal: 0),
        children: handlerData(),
      ),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];
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
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: new Column(
                  children: <Widget>[
                    // 图片
                    new Stack(
                      children: <Widget>[
                        new Image(
                          image: NetworkImage(handleUrl(item['img_url'])),
                          fit: BoxFit.cover,
                          height: 195,
                        ),
                        // 角标
                        item['product_tag_array'] != null &&
                                item['product_tag_array'].length > 0
                            ? new Positioned(
                                right: 5,
                                bottom: 5,
                                child: Image(
                                  image: NetworkImage(
                                      handleUrl(item['product_tag_array'][0])),
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            : new Container(),
                      ],
                    ),
                    new Container(
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: new Column(
                          children: <Widget>[
                            // 名称
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
                            // 简介
                            new Text(
                              item['product_brief'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: ScreenUtil().setSp(20),
                                color: Color.fromRGBO(0, 0, 0, .54),
                              ),
                            ),
                            // 价格
                            new Text.rich(
                              new TextSpan(
                                children: [
                                  new TextSpan(
                                    text: '￥' + item['product_price'],
                                    style: new TextStyle(
                                      fontSize: ScreenUtil().setSp(26),
                                      color: Color(int.parse(
                                              widget.data['btn_color']
                                                  .substring(1, 7),
                                              radix: 16) +
                                          0xFF000000),
                                    ),
                                  ),
                                  item['product_price'] !=
                                          item['product_org_price']
                                      ? new TextSpan(
                                          text: '￥' + item['product_org_price'],
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, .54),
                                            fontSize: ScreenUtil().setSp(20),
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        )
                                      : new TextSpan(),
                                ],
                              ),
                            ),
                            new FlatButton(
                              child: Text('立即购买'),
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              color: Color(int.parse(
                                      widget.data['btn_color'].substring(1, 7),
                                      radix: 16) +
                                  0xFF000000),
                              textColor: Color(int.parse(
                                      widget.data['btn_txt_color']
                                          .substring(1, 7),
                                      radix: 16) +
                                  0xFF000000),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
    }

    return items;
  }
}
