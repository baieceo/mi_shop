import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerLine extends StatefulWidget {
  final Map data;
  DividerLine({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<DividerLine> {
  @override
  Widget build(BuildContext context) {
    double height = 0.0;
    var color = 0x00000000;

    if (widget.data != null && widget.data['line_height'] != null) {
      height = ScreenUtil()
          .setWidth(double.parse(widget.data['line_height'].toString()));
    }

    if (widget.data != null && widget.data['line_color'] != null) {
      color = int.parse(widget.data['line_color'].substring(1, 7), radix: 16) +
          0xFF000000;
    }

    return Container(
      height: height,
      color: Color(color),
    );
  }
}
