import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  final Map tabs;
  final int pageId;
  final Function onTap;

  Nav({Key key, this.tabs, this.pageId, this.onTap}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<Nav> {
  int _pageId = 0;
  String _pageType;

  void _onItemTapped(String type, int id) {
    setState(() {
      _pageType = type;
      _pageId = id;
    });

    widget.onTap(_pageType, _pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        boxShadow: [
          //卡片阴影
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .2),
            offset: Offset(0, 4.0),
            blurRadius: 4.0,
            spreadRadius: -1,
          ),
        ],
      ),
      child: SizedBox(
        height: 32,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: handlerData(),
        ),
      ),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];

    if (widget.tabs != null &&
        widget.tabs['tabs'] != null &&
        widget.tabs['tabs'].length > 0) {
      for (var item in widget.tabs['tabs']) {
        items.add(new Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              decoration: BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        width: 2.0,
                        color: item['page_id'] == widget.pageId
                            ? Color(int.parse(
                                    item['word_selected_color'].substring(1, 7),
                                    radix: 16) +
                                0xFF000000)
                            : Color(0x00000000))),
              ),
              child: Text(
                item['name'],
                style: item['page_id'] == widget.pageId
                    ? TextStyle(
                        color: Color(int.parse(
                                item['word_selected_color'].substring(1, 7),
                                radix: 16) +
                            0xFF000000),
                      )
                    : TextStyle(
                        color: Color(int.parse(
                                item['word_unselected_color'].substring(1, 7),
                                radix: 16) +
                            0xFF000000),
                      ),
              ),
            ),
            onTap: () => _onItemTapped(item['page_type'], item['page_id']),
          ),
        ));
      }
    }

    return items;
  }
}
