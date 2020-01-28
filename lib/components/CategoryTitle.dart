import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTitle extends StatefulWidget {
  final Map data;
  CategoryTitle({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<CategoryTitle> {
  @override
  Widget build(BuildContext context) {
    List<Widget> components = List();

    if (widget.data != null && widget.data['category_name'] != null) {
      components.add(Container(
        alignment: Alignment.center,
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(120),
        margin: EdgeInsets.only(top: 20),
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: '一  ',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color(0xffe0e0e0),
              ),
            ),
            TextSpan(
              text: widget.data['category_name'],
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color(0xff3c3c3c),
              ),
            ),
            TextSpan(
              text: '  一',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color(0xffe0e0e0),
              ),
            ),
          ]),
        ),
      ));
    }

    return Column(
      children: components,
    );
  }
}
