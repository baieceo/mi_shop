import 'package:flutter/material.dart';
import 'package:mi_shop/pages/Activity.dart';
import 'package:mi_shop/pages/CommodityList.dart';
import 'package:mi_shop/pages/Tabs.dart';
import 'package:mi_shop/pages/Cart.dart';
import 'package:mi_shop/pages/Category.dart';
import 'package:mi_shop/pages/Product.dart';
import 'package:mi_shop/pages/Mine.dart';
import 'package:mi_shop/pages/Search.dart';

//配置路由
final Map<String, WidgetBuilder> routes = {
  '/': (context) => Tabs(),
  '/cart': (context) => Cart(),
  '/category': (context) => Category(),
  '/product': (context, {arguments}) => Product(arguments: arguments),
  '/activity': (context, {arguments}) => Activity(arguments: arguments),
  '/mine': (context) => Mine(),
  '/search': (context) => Search(),
  '/commoditylist': (context, {arguments}) =>
      CommodityList(arguments: arguments),
};

var handleGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
