import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewRecommendClass extends StatefulWidget {
  final Map data;
  const ViewRecommendClass({Key key, this.data}) : super(key: key);

  State<ViewRecommendClass> createState() {
    return new _Component();
  }
}

class _Component extends State<ViewRecommendClass> {
  List<Widget> components = [];

  Widget layout(BuildContext context) {
    components = [];

    if (widget.data != null && widget.data['recommend_class'] != null) {
      widget.data['recommend_class'].forEach((item) {
        components.add(new GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/searchlist',
              arguments: {
                'key': item['name'],
              },
            );
          },
          child: new Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(16),
                horizontal: ScreenUtil().setWidth(32)),
            color: Color(0xfff5f5f5),
            child: new Text(
              item['name'],
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, .87),
                fontSize: ScreenUtil().setSp(26),
              ),
            ),
          ),
        ));
      });
    }

    return new Container(
      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(32)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(36)),
            child: new Align(
              alignment: Alignment.topLeft,
              child: new Text(
                widget.data['recommend_title'],
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, .87),
                  fontSize: ScreenUtil().setSp(32),
                ),
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(36)),
            child: new Wrap(
              spacing: ScreenUtil().setWidth(16),
              runSpacing: ScreenUtil().setWidth(16),
              children: components,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }
}
