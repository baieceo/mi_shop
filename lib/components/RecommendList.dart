import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/view/ListTwoType4.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/utils/index.dart';

class RecommendList extends StatefulWidget {
  final String source;
  final String referer;
  RecommendList({Key key, this.source, this.referer}) : super(key: key);

  @override
  State<RecommendList> createState() {
    return new Page();
  }
}

class Page extends State<RecommendList> {
  Map pageData = Map();

  void initState() {
    super.initState();

    requestAPI();
  }

  // 渲染头部
  Widget renderHeader() {
    List<Widget> items = [];

    if (pageData['header'] != null) {
      pageData['header']['body']['items'].forEach((item) {
        items.add(new Image(
          image: NetworkImage(handleUrl(item['img_url'])),
          width: ScreenUtil().setWidth(item['w']),
          height: ScreenUtil().setHeight(item['h']),
        ));
      });
    }

    return new Container(
      child: new Column(
        children: items,
      ),
    );
  }

  // 渲染内容
  Widget renderContainer() {
    if (pageData['recom_list'] != null) {
      return new ListTwoType4(data: pageData['recom_list']);
    } else {
      return new Container();
    }
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          renderHeader(),
          renderContainer(),
        ],
      ),
    );
  }

  void requestAPI() async {
    var res = await Http.post(
      path: RECOMMEND_BLANK,
      data: {
        'source': widget.source ?? 'list',
      },
      options: Options(headers: {
        HttpHeaders.refererHeader: widget.referer ?? 'https://m.mi.com/',
      }),
    );

    setState(() {
      pageData = res;
    });
  }
}
