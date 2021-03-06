import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mi_shop/utils/index.dart';

class Gallery extends StatefulWidget {
  final List items;
  final double size;
  final double height;
  final double space;

  Gallery({Key key, this.items, this.size, this.height, this.space})
      : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight = widget.height == null ? 206 : widget.height;
    final double dotSize = widget.size == null ? 8.0 : widget.size;
    final double dotSpace = widget.space == null ? 5.0 : widget.space;

    if (widget.items != null && widget.items.length > 0) {
      return Container(
        height: itemHeight,
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {
                var item = widget.items[index];

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
              child: new FadeInImage.assetNetwork(
                placeholder: 'images/placeholder.png',
                image: handleUrl(widget.items[index]['img_url']),
              ),
            );
          },
          itemHeight: itemHeight,
          itemCount: widget.items.length,
          pagination: new SwiperPagination(
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 0,
            ),
            builder: DotSwiperPaginationBuilder(
              space: dotSpace,
              size: dotSize,
              color: Color.fromRGBO(255, 255, 255, .2),
              activeColor: Colors.white,
              activeSize: dotSize,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        height: itemHeight,
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('images/placeholder.png'),
        ),
      );
    }
  }
}
