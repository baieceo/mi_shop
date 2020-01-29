import 'package:flutter/material.dart';
import 'package:mi_shop/routes/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = '小米商城';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: handleGenerateRoute,
    );
  }
}
