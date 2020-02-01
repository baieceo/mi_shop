import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mi_shop/components/HeaderNav.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/components/Nav.dart';
import 'package:mi_shop/components/PageRender.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Home> {
  Map pageData = Map();
  int pageId = 0;
  String pageType = 'home';
  bool loading = true;

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  Widget build(BuildContext context) {
    return layout(context);
  }

  // 顶部栏
  Widget topBar(BuildContext context) {
    return new HeaderNav(
      left: Container(
        child: Image(
          image: new AssetImage('images/logo.png'),
          height: 15,
        ),
      ),
      content: Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            width: 1,
            color: Color(0xffe5e5e5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        child: Scaffold(
          body: Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.search,
                  color: Color(0x4D000000),
                  size: 3.0,
                ),
                margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
              ),
              Expanded(
                child: new TextField(
                  decoration: new InputDecoration(
                    hintText: '搜索商品名称',
                    hintStyle: new TextStyle(
                      fontSize: 13.0,
                      color: Color(0x4D000000),
                    ),
                    fillColor: Color(0xffffffff),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      right: Container(
        child: Image(
          image: new AssetImage('images/user.png'),
          height: 18,
        ),
      ),
    );
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: topBar(context),
          ),
          Expanded(
            flex: 0,
            child: new Nav(
              tabs: pageData,
              pageId: pageId,
              onTap: (String type, int id) {
                setState(() {
                  pageId = id;
                  pageType = type;
                });

                requestAPI();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: loading == true
                  ? new Container(
                      height: 500,
                      child: new Center(
                        child: new Image(
                          image: AssetImage('images/placeholder.png'),
                        ),
                      ),
                    )
                  : new Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: pageData['data'] != null &&
                              pageData['data']['sections'] != null
                          ? new PageRender(
                              data: pageData['data']['sections'],
                            )
                          : new Container(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void requestAPI() async {
    setState(() {
      loading = true;
    });

    var res = await Http.post(
      path: HOME_PAGE,
      data: {'page_type': pageType, 'page_id': pageId.toString()},
    );

    setState(() {
      pageData = res;
      loading = false;
    });
  }
}
