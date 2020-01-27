import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Gallery extends StatefulWidget {
  final List items;
  Gallery({Key key, this.items}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight = ScreenUtil().setWidth(360);

    if (widget.items != null && widget.items.length > 0) {
      return Container(
        height: itemHeight,
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              'https:' + widget.items[index]['img_url'],
              fit: BoxFit.cover,
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
              space: 5.0,
              size: 8.0,
              color: Color.fromRGBO(255, 255, 255, .2),
              activeColor: Colors.white,
              activeSize: 8.0,
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
        child: SizedBox(
          height: 35,
          width: 35,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.grey[350]),
            strokeWidth: 3.0,
          ),
        ),
      );
    }
  }
}
