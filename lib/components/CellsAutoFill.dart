import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class CellsAutoFill extends StatefulWidget {
  final Map data;
  final bool autoFill;
  const CellsAutoFill({Key key, this.data, this.autoFill}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<CellsAutoFill> {
  @override
  Widget build(BuildContext context) {
    List<Widget> components = [];

    if (widget.data != null &&
        widget.data['items'] != null &&
        widget.data['items'].length > 0) {
      // print(widget.data['items']);
      widget.data['items'].forEach((item) {
        var x = item['x'];
        var y = item['y'];
        var w = item['w'];
        var h = item['h'];

        if (item['x'] == null) {
          x = 0;
        }

        if (item['y'] == null) {
          y = 0;
        }

        if (widget.autoFill == true) {
          x = null;
          y = null;
          w = null;
          h = null;
        } else {
          x = ScreenUtil().setWidth(x);
          y = ScreenUtil().setWidth(y);
          w = ScreenUtil().setWidth(w);
          h = ScreenUtil().setWidth(h);
        }

        components.add(Positioned(
          top: y,
          left: x,
          child: GestureDetector(
            onTap: () {
              String actionType = item['action']['type'];
              String path = item['action']['path'];

              // 活动
              if (actionType == 'activity') {
                RegExp reg = new RegExp(r'id=(\d+)');
                Iterable<Match> matchesPath = reg.allMatches(path);
                String id;

                for (Match m in matchesPath) {
                  for (int i = 0; i < m.groupCount + 1; i++) {
                    String match = m.group(i);

                    if (i == 1) {
                      id = match;
                    }
                  }
                }

                Navigator.pushNamed(
                  context,
                  '/activity',
                  arguments: {
                    'id': id,
                  },
                );
              }

              // 产品
              if (actionType == 'product') {
                Navigator.pushNamed(
                  context,
                  '/product',
                  arguments: {
                    'product_id': path.toString(),
                  },
                );
              }
            },
            child: Image(
              image: NetworkImage(handleUrl(item['img_url'])),
              width: w,
              height: h,
            ),
          ),
        ));
      });

      return Container(
        width: widget.autoFill == true
            ? null
            : ScreenUtil().setWidth(widget.data['w']),
        height: widget.autoFill == true
            ? null
            : ScreenUtil().setWidth(widget.data['h']),
        child: Stack(
          children: components,
        ),
      );
    } else {
      return Container();
    }
  }
}
