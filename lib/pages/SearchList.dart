import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mi_shop/components/HeaderNav.dart';
import 'package:mi_shop/components/RecommendList.dart';
import 'package:mi_shop/components/view/ViewRecommendClass.dart';
import 'package:mi_shop/components/view/ViewSearchProduct.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/http/index.dart';

class SearchList extends StatefulWidget {
  final Map arguments;

  SearchList({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<SearchList> {
  int mainSort = 0; // 排序 0 综合 1 销量 2 价格 4 新品
  String sortBy = 'asc'; // asc dsc
  Map pageData;
  List<Widget> _searchList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();

    requestAPI(0);
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  TextEditingController _searchKeyController = TextEditingController();

  // 渲染头部
  Widget renderSearchBar(BuildContext context) {
    if (widget.arguments != null && widget.arguments['key'] != null) {
      _searchKeyController.text = widget.arguments['key'];
    }

    return new HeaderNav(
      color: Color(0xfffafafa),
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
              controller: _searchKeyController,
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
              onSubmitted: (String value) {
                Navigator.pushNamed(
                  context,
                  '/searchlist',
                  arguments: {'key': value},
                );
              },
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
            Navigator.pushNamed(
              context,
              '/searchlist',
              arguments: {'key': _searchKeyController.text},
            );
          },
        ),
      ),
    );
  }

  // 渲染筛选
  Widget renderFilterBar(BuildContext context) {
    return new Container(
      color: Color(0xfffafafa),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              print('综合');
              // int mainSort = 0; // 排序 0 综合 1 销量 2 价格 4 新品
              // String sortBy = 'asc'; // asc dsc
              setState(() {
                pageData = {};
                mainSort = 0;
              });

              requestAPI(0);
            },
            child: new Container(
              height: ScreenUtil().setWidth(72),
              child: new Center(
                child: new Text(
                  '综合',
                  style: TextStyle(
                    color: mainSort == 0
                        ? Color(0xffff6700)
                        : Color.fromRGBO(0, 0, 0, .54),
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              setState(() {
                pageData = {};
                mainSort = 4;
              });

              requestAPI(4);
            },
            child: new Container(
              height: ScreenUtil().setWidth(72),
              child: new Center(
                child: new Text(
                  '新品',
                  style: TextStyle(
                    color: mainSort == 4
                        ? Color(0xffff6700)
                        : Color.fromRGBO(0, 0, 0, .54),
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              setState(() {
                pageData = {};
                mainSort = 1;
              });

              requestAPI(1);
            },
            child: new Container(
              height: ScreenUtil().setWidth(72),
              child: new Center(
                child: new Text(
                  '销量',
                  style: TextStyle(
                    color: mainSort == 1
                        ? Color(0xffff6700)
                        : Color.fromRGBO(0, 0, 0, .54),
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              setState(() {
                pageData = {};
                mainSort = 2;
              });

              requestAPI(2);
            },
            child: new Container(
              height: ScreenUtil().setWidth(72),
              child: new Center(
                child: new Text(
                  '价格',
                  style: TextStyle(
                    color: mainSort == 2
                        ? Color(0xffff6700)
                        : Color.fromRGBO(0, 0, 0, .54),
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 渲染头部
  Widget renderHeader(BuildContext context) {
    return new Column(
      children: <Widget>[
        renderSearchBar(context),
        renderFilterBar(context),
      ],
    );
  }

  // 渲染搜索列表
  Widget renderSearchList(BuildContext context) {
    if (pageData != null && pageData['list_v2'] != null) {
      _searchList = [];

      pageData['list_v2'].forEach((item) {
        if (item['view_type'] == 'view_search_product') {
          _searchList.add(new Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, .15),
                  width: .5,
                ),
              ),
            ),
            child: new ViewSearchProduct(data: item['body']),
          ));
        }

        if (item['view_type'] == 'view_recommend_class') {
          _searchList.add(new Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, .15),
                  width: .5,
                ),
              ),
            ),
            child: new ViewRecommendClass(data: item['body']),
          ));
        }
      });

      return new Container(
        child: new Column(
          children: _searchList,
        ),
      );
    } else {
      return new Container();
    }
  }

  // 渲染主体
  Widget renderContent(BuildContext context) {
    if (loading == true) {
      return new Expanded(
        flex: 1,
        child: new Container(
          color: Colors.white,
          child: new Center(
            child: new Image(
              image: AssetImage('images/placeholder.png'),
            ),
          ),
        ),
      );
    } else {
      return new Expanded(
        flex: 1,
        child: new Container(
          color: Colors.white,
          child: new ListView(
            padding: EdgeInsets.only(top: 0, bottom: 40),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              // 渲染搜索列表
              renderSearchList(context),
              // 推荐
              RecommendList(
                referer: 'https://m.mi.com/search/list?key=' +
                    (widget.arguments != null ? widget.arguments['key'] : ''),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new SafeArea(
        child: new Column(
          children: <Widget>[
            renderHeader(context),
            renderContent(context),
          ],
        ),
      ),
    );
  }

  void requestAPI(int sort) async {
    setState(() {
      loading = true;
    });

    var res = await Http.post(path: SEARCH_QUERY, data: {
      'main_sort': sort.toString(),
      'query': widget.arguments != null ? widget.arguments['key'] : '小米手环4',
      'version': '2',
      'page_index': '1',
      'page_size': '20'
    });

    setState(() {
      pageData = res;
      loading = false;
    });
  }
}
