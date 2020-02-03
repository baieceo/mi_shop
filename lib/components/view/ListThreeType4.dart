import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class ListThreeType4 extends StatefulWidget {
  final Map data;
  ListThreeType4({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListThreeType4> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: Color(handleColor(widget.data['bg_color'])),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: new GridView(
        shrinkWrap: true, // 解决 ListView 和 GridView 混合使用报错问题
        physics:
            new NeverScrollableScrollPhysics(), // 解决 ListView 和 GridView 混合使用滚动冲突问题
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 30,
          childAspectRatio: 128 / 225,
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
              borderRadius: BorderRadius.circular(5),
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.all(0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                        color: Color(handleColor(item['img_url_color'])),
                      ),
                      child: new Image(
                        image: NetworkImage(handleUrl(item['img_url'])),
                        fit: BoxFit.cover,
                        height: 128,
                      ),
                    ),
                    new Container(
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: new Column(
                          children: <Widget>[
                            new Text(
                              item['product_name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Color(0xff3c3c3c),
                              ),
                            ),
                            new Text(
                              item['product_brief'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                color: Color(0xff3c3c3c),
                              ),
                            ),
                            new Text.rich(
                              TextSpan(
                                children: [
                                  new TextSpan(
                                    text: '￥' + item['product_price'],
                                    style: TextStyle(
                                      color: Color(handleColor(
                                          widget.data['btn_color'])),
                                      fontSize: ScreenUtil().setSp(26),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  item['show_price_qi'] == true
                                      ? new TextSpan(
                                          text: '起',
                                          style: TextStyle(
                                            color: Color(handleColor(
                                                widget.data['btn_color'])),
                                            fontSize: ScreenUtil().setSp(20),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : new TextSpan(text: ''),
                                  new TextSpan(text: '  '),
                                  new TextSpan(
                                    text: item['product_price'] !=
                                            item['product_org_price']
                                        ? ('￥' + item['product_org_price'])
                                        : '',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: ScreenUtil().setSp(20),
                                    ),
                                  ),
                                ],
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
          ),
        );
      });
    }

    return items;
  }
}
