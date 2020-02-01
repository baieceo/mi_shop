import 'package:flutter/material.dart';
import 'package:mi_shop/utils/index.dart';

class ListOneType15 extends StatefulWidget {
  final Map data;
  ListOneType15({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListOneType15> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: handlerData(),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];

    if (widget.data['items'] != null && widget.data['items'].length > 0) {
      widget.data['items'].forEach((item) {
        items.add(new GestureDetector(
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color(handleColor(widget.data['bg_color'])),
            ),
            child: new Column(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    new Image(
                      image: NetworkImage(handleUrl(item['img_url'])),
                    ),
                    item['product_tag_array'] != null &&
                            item['product_tag_array'].length > 0
                        ? new Positioned(
                            right: 5,
                            bottom: 5,
                            child: new Image(
                              image: NetworkImage(
                                  handleUrl(item['product_tag_array'][0])),
                              width: 65,
                              height: 65,
                            ),
                          )
                        : new Container(),
                  ],
                ),
                new Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                            flex: 3,
                            child: new Text(
                              item['product_name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, .87),
                                fontSize: 22,
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 0,
                            child: new Text.rich(
                              new TextSpan(
                                children: [
                                  new TextSpan(
                                      text: '￥' + item['product_price'],
                                      style: TextStyle(
                                        color: Color(0xffea625b),
                                        fontSize: 20,
                                      )),
                                  item['show_price_qi'] == true
                                      ? new TextSpan(
                                          text: ' 起',
                                          style: TextStyle(
                                            color: Color(0xffea625b),
                                            fontSize: 12,
                                          ))
                                      : new TextSpan()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                            flex: 1,
                            child: new Text(
                              item['product_brief'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, .54),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          new FlatButton(
                            color: Color(handleColor(widget.data['btn_color'])),
                            textColor: Color(
                                handleColor(widget.data['btn_txt_color'])),
                            child: Text(item['btn_txt'] ?? '立即购买'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      });
    }

    return items;
  }
}
