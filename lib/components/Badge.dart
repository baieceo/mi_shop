import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Badge extends StatefulWidget {
  final int value;
  final double top;
  final double right;
  final bool hidden;
  final Widget child;
  final int max;
  final double minWidth;
  final double minHeight;
  final Color color;
  final Color textColor;
  final double textSize;

  const Badge({
    Key key,
    this.value,
    this.top,
    this.right,
    this.hidden,
    this.child,
    this.max,
    this.minWidth,
    this.minHeight,
    this.color,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  @override
  createState() => new _Badge();
}

class _Badge extends State<Badge> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        widget.child,
        widget.hidden == true
            ? new Container()
            : new Positioned(
                top: widget.top ?? 0,
                right: widget.right ?? 0,
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: widget.minWidth ?? 10,
                    minHeight: widget.minHeight ?? 10,
                  ),
                  child: new Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    decoration: BoxDecoration(
                      color: widget.color ?? Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: new Center(
                      child: new Text(
                        widget.max != null &&
                                widget.value != null &&
                                widget.value > widget.max
                            ? (widget.max.toString() + '+')
                            : widget.value.toString(),
                        style: TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontSize: widget.textSize ?? 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
