import 'package:flutter/material.dart';

class HeaderNav extends StatefulWidget {
  final Container left;
  final Container right;
  final Container content;
  final double height;

  HeaderNav({Key key, this.left, this.right, this.content, this.height})
      : super(key: key);

  @override
  createState() => new HeaderComponent();
}

class HeaderComponent extends State<HeaderNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
      ),
      height: widget.height ?? 40.0,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: widget.left,
            flex: 1,
          ),
          Expanded(
            child: widget.content,
            flex: 6,
          ),
          Expanded(
            child: widget.right,
            flex: 1,
          ),
        ],
      ),
    );
  }
}
