import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListActionTitle extends StatefulWidget {
  final Map data;
  ListActionTitle({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<ListActionTitle> {
  @override
  Widget build(BuildContext context) {
    List<Widget> components = List();

    if (widget.data != null &&
        widget.data['items'] != null &&
        widget.data['items'].length > 0) {
      widget.data['items'].forEach((item) {
        components.add(GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setWidth(100),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              item['action_title'],
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromRGBO(0, 0, 0, .6),
              ),
            ),
          ),
        ));
      });
    }

    return Column(
      children: components,
    );
  }
}
