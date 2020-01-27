import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    requestAPI();
  }

  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: new HeaderNav(
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
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 4),
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
              ),
            ),
            Expanded(
              flex: 0,
              child: new Nav(
                tabs: pageData,
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: new PageRender(
                  data: pageData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestAPI() async {
    var res = await Http.post(
      path: HOME_PAGE,
      data: {
        'page_type': 'home',
      },
    );

    setState(() {
      pageData = res;
    });
  }
}
