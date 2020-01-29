import 'package:flutter/material.dart';
import 'package:mi_shop/components/Gallery.dart';
import 'package:mi_shop/components/CellsAutoFill.dart';
import 'package:mi_shop/components/DividerLine.dart';
import 'package:mi_shop/components/ListTwoType1.dart';
import 'package:mi_shop/components/ListTwoType2.dart';
import 'package:mi_shop/components/ListTwoType3.dart';
import 'package:mi_shop/components/ListThreeType4.dart';
import 'package:mi_shop/components/ListTwoType13.dart';
import 'package:mi_shop/components/ListTwoType14.dart';
import 'package:mi_shop/components/ListOneType14.dart';
import 'package:mi_shop/components/ListOneType15.dart';
import 'package:mi_shop/components/ListActionTitle.dart';
import 'package:mi_shop/components/CategoryTitle.dart';
import 'package:mi_shop/components/CategoryGroup.dart';

class PageRender extends StatefulWidget {
  final List data;
  PageRender({Key key, this.data}) : super(key: key);
  @override
  createState() => new MyComponent();
}

class MyComponent extends State<PageRender> {
  List components = List();

  @override
  Widget build(BuildContext context) {
    List<Widget> components = List();

    if (widget.data.length > 0) {
      widget.data.forEach((section) {
        // 轮播
        if (section['view_type'] == 'gallery') {
          components.add(new Gallery(items: section['body']['items']));
        }

        // 图片
        if (section['view_type'] == 'cells_auto_fill') {
          components.add(new CellsAutoFill(data: section['body']));
        }

        // 分割线
        if (section['view_type'] == 'divider_line') {
          components.add(new DividerLine(data: section['body']));
        }

        // 两栏列表1
        if (section['view_type'] == 'list_two_type1') {
          components.add(new ListTwoType1(data: section['body']));
        }

        // 两栏列表2
        if (section['view_type'] == 'list_one_type2') {
          components.add(new ListTwoType2(data: section['body']));
        }

        // 两栏列表3
        if (section['view_type'] == 'list_one_type3') {
          components.add(new ListTwoType3(data: section['body']));
        }

        // 三栏列表4
        if (section['view_type'] == 'list_three_type4') {
          components.add(new ListThreeType4(data: section['body']));
        }

        // 两栏列表13
        if (section['view_type'] == 'list_two_type13') {
          components.add(new ListTwoType13(data: section['body']));
        }

        // 两栏列表14
        if (section['view_type'] == 'list_two_type14') {
          components.add(new ListTwoType14(data: section['body']));
        }

        // 一栏列表14
        if (section['view_type'] == 'list_one_type14') {
          components.add(new ListOneType14(data: section['body']));
        }

        // 一栏列表15
        if (section['view_type'] == 'list_one_type15') {
          components.add(new ListOneType15(data: section['body']));
        }

        // 列表标题
        if (section['view_type'] == 'list_action_title') {
          components.add(new ListActionTitle(data: section['body']));
        }

        // 分类标题
        if (section['view_type'] == 'category_title') {
          components.add(new CategoryTitle(data: section['body']));
        }

        // 分类组
        if (section['view_type'] == 'category_group') {
          components.add(new CategoryGroup(data: section['body']));
        }
      });
    }

    if (widget.data != null) {
      return Column(
        children: components,
      );
    } else {
      return Container(
        height: 500,
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
