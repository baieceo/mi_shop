import 'package:flutter/cupertino.dart';

class WhiteSpace extends StatelessWidget {
  final double size;
  final Color color;

  WhiteSpace({Key key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: this.color ?? null,
      ),
      height: this.size,
    );
  }
}
