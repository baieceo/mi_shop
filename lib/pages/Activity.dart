import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mi_shop/http/index.dart';
import 'package:mi_shop/http/api.dart';
import 'package:mi_shop/components/PageRender.dart';

class Activity extends StatefulWidget {
  final Map arguments;
  Activity({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<Activity> {
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

  Widget topBar(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: new Container(
              margin: EdgeInsets.all(10),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: new IconButton(
                iconSize: 20,
                icon: Icon(Icons.arrow_back_ios),
                color: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    if (loading == true) {
      return new Container(
        height: 500,
        child: new Center(
          child: new Image(
            image: AssetImage('images/placeholder.png'),
          ),
        ),
      );
    } else {
      return new ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          new Container(
            // padding: EdgeInsets.only(bottom: 50),
            child: new PageRender(
              data: pageData['data']['sections'],
            ),
          )
        ],
      );
    }
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: mainBody(context),
          ),
          new Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: new Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0),
              ),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: topBar(context),
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

    var res = await Http.jsonp(
      path: ACTIVITY_PAGE,
      data: {
        'client_id': '180100031051',
        'id': widget.arguments['id'],
        'webp': '0',
        'time': '1580301629830',
      },
      callback: {
        'param': 'cb_home',
      },
    );

    setState(() {
      pageData = res;
      loading = false;
    });
  }
}
