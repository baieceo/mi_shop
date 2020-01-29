import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/components/PageRender.dart';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Category> {
  List pageData = List();
  List listData = List();
  ScrollController _scrollController = new ScrollController();

  // 分类选择索引
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  @override
  void dispose() {
    // 避免内存泄露，调用 _scrollController.dispose
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  // 布局
  Widget layout(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: navBar(context),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  // 左侧栏
                  Expanded(
                    flex: 1,
                    child: sideBar(context),
                  ),
                  // 主体
                  Expanded(
                    flex: 3,
                    child: mainBody(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 导航栏
  Widget navBar(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        color: Color.fromRGBO(242, 242, 242, 1),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: IconButton(
              color: Color(0XFFCCCCCC),
              iconSize: 25.0,
              icon: Icon(Icons.arrow_back_ios),
              splashColor: Colors.transparent,
              onPressed: () {
                print('返回');
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '分类',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Color(0XFF666666),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              color: Color(0XFFCCCCCC),
              iconSize: 35.0,
              icon: Icon(Icons.search),
              splashColor: Colors.transparent,
              onPressed: () {
                print('搜索');
              },
            ),
          ),
        ],
      ),
    );
  }

  // 左侧栏
  Widget sideBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.all(20),
        controller: _scrollController,
        children: renderSideBar(),
      ),
    );
  }

  // 主体
  Widget mainBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          new PageRender(
            data: listData,
          ),
        ],
      ),
    );
  }

  List<Widget> renderSideBar() {
    List<Widget> list = [];

    pageData.forEach((item) {
      list.add(GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              item['category_name'],
              style: TextStyle(
                color: item['category_id'] == _selectedIndex
                    ? Color(0xfffb7d34)
                    : Color(0xff3c3c3c),
                fontSize: ScreenUtil().setSp(28),
              ),
              textScaleFactor:
                  item['category_id'] == _selectedIndex ? 1.2 : 1.0,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            listData = item['category_list'];
            _selectedIndex = item['category_id'];

            _scrollController.animateTo(.0,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          });
        },
      ));
    });

    return list;
  }

  void requestAPI() async {
    var res = await Http.post(path: CATEGORY, data: {});

    setState(() {
      pageData = res;
      listData = pageData[0]['category_list'];
      _selectedIndex = pageData[0]['category_id'];
    });
  }
}
