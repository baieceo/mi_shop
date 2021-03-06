import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/utils/index.dart';

class CategoryGroup extends StatefulWidget {
  final Map data;
  CategoryGroup({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<CategoryGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8),
      child: GridView(
        shrinkWrap: true, // 解决 ListView 和 GridView 混合使用报错问题
        physics:
            new NeverScrollableScrollPhysics(), // 解决 ListView 和 GridView 混合使用滚动冲突问题
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 30,
          childAspectRatio: 88 / 96,
        ),
        padding: EdgeInsets.symmetric(horizontal: 0),
        children: handlerData(),
      ),
    );
  }

  List<Widget> handlerData() {
    List<Widget> items = [];
    if (widget.data['items'] != null) {
      widget.data['items'].forEach((item) {
        String imgUrl = handleUrl(item['img_url']);

        items.add(
          GestureDetector(
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

              // 分类
              if (actionType == 'cate') {
                Navigator.pushNamed(
                  context,
                  '/commoditylist',
                  arguments: {
                    'id': path.toString(),
                  },
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setWidth(120),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            item['product_name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Color.fromRGBO(0, 0, 0, .54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    }

    return items;
  }
}
