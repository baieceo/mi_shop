import 'package:flutter/material.dart';
import 'package:mi_shop/utils/index.dart';

class ListTwoType4 extends StatefulWidget {
  final List data;
  ListTwoType4({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListTwoType4> {
  @override
  Widget build(BuildContext context) {
    List<Widget> components = [];

    widget.data.forEach((item) {
      components.add(new GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: {
              'product_id': item['action']['path'],
            },
          );
        },
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  image: new DecorationImage(
                    image: AssetImage('images/placeholder.png'),
                  ),
                ),
                child: new Image(
                  image: NetworkImage(handleUrl(item['image_url'])),
                  height: 208,
                  fit: BoxFit.cover,
                ),
              ),
              new Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      item['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 18,
                      ),
                    ),
                    new Text.rich(
                      new TextSpan(
                        children: [
                          new TextSpan(
                            text: '￥' + item['price'] + '  ',
                            style: TextStyle(
                              color: Color(0xffff6700),
                              fontSize: 18,
                            ),
                          ),
                          item['price'] != item['market_price']
                              ? new TextSpan(
                                  text: '￥' + item['market_price'],
                                  style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ))
                              : new TextSpan(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    });

    return new GridView(
      shrinkWrap: true, // 解决 ListView 和 GridView 混合使用报错问题
      physics:
          new NeverScrollableScrollPhysics(), // 解决 ListView 和 GridView 混合使用滚动冲突问题
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 30,
        childAspectRatio: 205 / 300,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0),
      children: components,
    );
  }
}
