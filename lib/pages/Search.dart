import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/view/CellsAutoFill.dart';
import 'package:mi_shop/components/HeaderNav.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/utils/index.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Page();
  }
}

class Page extends State<Search> {
  Map pageData;

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  // 渲染头部
  Widget renderNavbar(BuildContext context) {
    return new HeaderNav(
      height: 50,
      left: new Container(
        child: new IconButton(
          color: Color(0XFFCCCCCC),
          iconSize: 25.0,
          icon: Icon(Icons.arrow_back_ios),
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      content: new Container(
        child: new Theme(
          data: new ThemeData(
              primaryColor: Color(0xffe5e5e5), hintColor: Color(0xffe5e5e5)),
          child: new ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: ScreenUtil().setWidth(52),
            ),
            child: new TextField(
              autofocus: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20), vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: '搜索商品名称',
                hintStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Color(0xffcccccc),
                ),
              ),
              cursorColor: Colors.grey,
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ),
      right: new Container(
        child: new IconButton(
          color: Color(0XFFCCCCCC),
          iconSize: ScreenUtil().setWidth(50),
          icon: Icon(Icons.search),
          splashColor: Colors.transparent,
          onPressed: () {
            print('搜索');
          },
        ),
      ),
    );
  }

  List<Widget> promotions = [];
  List<Widget> keyList = [];
  List<Widget> hotList = [];

  // 渲染标题
  Widget renderTitle(BuildContext context, String title) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      height: ScreenUtil().setWidth(80),
      child: new Align(
        alignment: Alignment.centerLeft,
        child: new Text(
          title,
          style: TextStyle(
            color: Color(0xff3c3c3c),
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
    );
  }

  // 渲染广告
  Widget renderPromotion(BuildContext context) {
    promotions = [];

    promotions.add(renderTitle(context, '热门搜索'));

    if (pageData != null &&
        pageData['ad_list'] != null &&
        pageData['ad_list'].length > 0) {
      pageData['ad_list'].forEach((item) {
        // print(item['view_type']);
        if (item['view_type'] == 'cells_auto_fill') {
          promotions.add(new CellsAutoFill(data: item['body'], autoFill: true));
        }
      });
    }

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: promotions,
      ),
    );
  }

  // 渲染关键词
  Widget renderKeyList(BuildContext context) {
    keyList = [];

    if (pageData != null &&
        pageData['keywords'] != null &&
        pageData['keywords'].length > 0) {
      pageData['keywords'].forEach((item) {
        keyList.add(new GestureDetector(
          onTap: () {
            print('点击关键词');
          },
          child: new Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setWidth(10)),
            decoration: BoxDecoration(
              color: Color(handleColor(item['back_n'])),
              border: Border.all(
                color: Color(handleColor(item['border_n'])),
                width: .5,
              ),
            ),
            child: new Text(
              item['word'],
              maxLines: 1,
              style: TextStyle(
                height: 1.5,
                color: Color(handleColor(item['font_n'])),
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
        ));
      });
    }

    return new Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(20)),
      child: new Wrap(
        spacing: ScreenUtil().setWidth(20),
        runSpacing: ScreenUtil().setWidth(20),
        children: keyList,
      ),
    );
  }

  // 渲染常用分类
  Widget renderHotList(BuildContext context) {
    hotList = [];

    if (pageData != null &&
        pageData['hot_class'] != null &&
        pageData['hot_class'].length > 0) {
      pageData['hot_class'].forEach((item) {
        hotList.add(new GestureDetector(
          onTap: () {
            print('点击常用分类');
          },
          child: new Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setWidth(10)),
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
            ),
            child: new Text(
              item['name'],
              maxLines: 1,
              style: TextStyle(
                height: 1.5,
                color: Color.fromRGBO(0, 0, 0, .54),
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
        ));
      });
    }

    return new Container(
      child: new Column(
        children: [
          renderTitle(context, '常用分类'),
          new LimitedBox(
            maxHeight: ScreenUtil().setHeight(135),
            child: new Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              child: new Wrap(
                spacing: ScreenUtil().setWidth(20),
                runSpacing: ScreenUtil().setWidth(20),
                children: hotList,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int menuIndex = 0;
  List<Widget> menuComponents = [];

  Widget layout(BuildContext context) {
    return new Container(
      child: new ListView(
        children: <Widget>[
          renderNavbar(context),
          renderPromotion(context),
          renderKeyList(context),
          renderHotList(context),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: layout(context),
      ),
    );
  }

  // 请求数据
  void requestAPI() async {
    var res = await Http.post(path: SEARCH_DEFAULT, data: {});

    setState(() {
      pageData = res;
    });
  }
}
