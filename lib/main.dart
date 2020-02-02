import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mi_shop/routes/Routes.dart';
import 'package:mi_shop/provider/cart.dart';

void main() {
  List<SingleChildCloneableWidget> providers = [];

  // 注册 Provider providers..add()..add()
  providers..add(ChangeNotifierProvider.value(value: CartProvider()));

  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String _title = '小米商城';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      initialRoute: '/search',
      onGenerateRoute: handleGenerateRoute,
    );
  }
}
