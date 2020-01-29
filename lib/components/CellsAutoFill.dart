import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellsAutoFill extends StatefulWidget {
  final Map data;
  CellsAutoFill({Key key, this.data}) : super(key: key);
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

        x = ScreenUtil().setWidth(x);
        y = ScreenUtil().setWidth(y);
        w = ScreenUtil().setWidth(w);
        h = ScreenUtil().setWidth(h);

        RegExp isUri = new RegExp(r'^\/\/');

        if (isUri.hasMatch(item['img_url'])) {
          item['img_url'] = 'https:' + item['img_url'];
        }

        components.add(Positioned(
          top: y,
          left: x,
          child: GestureDetector(
            onTap: () {
              String actionType = item['action']['type'];

              if (actionType == 'activity') {
                String path = item['action']['path'];
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
              print(item);
            },
            child: Image(
              image: NetworkImage(item['img_url']),
              width: w,
            ),
          ),
        ));
      });

      return Container(
        width: ScreenUtil().setWidth(widget.data['w']),
        height: ScreenUtil().setWidth(widget.data['h']),
        child: Stack(
          children: components,
        ),
      );
    } else {
      return Container();
    }
  }
}
