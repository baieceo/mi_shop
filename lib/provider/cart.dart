import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_shop/model/cartInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]'; // 持久化存储
  List<CartInfoModel> _cartList = [];
  List<CartInfoModel> get cartList => _cartList;

  // 异步方法, 购物车操作
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); // 持久化获取
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    // 声明 list 强制类型是 Map
    List<Map> tempList = (temp as List).cast(); // 把 temp 转成 list
    bool isHave = false; // 是否已经存在了这条记录
    int ival = 0; // foreach 循环的索引
    // 循环判断列表是否存在该 goodsId 的商品，如果有就数量 +1
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        _cartList[ival].count++;

        isHave = true;
      }
      ival++;
    });
    // 没有不存在这个商品，就把商品的 json 数据加入的 tempList 中
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId, // 传入进来的值
        'goodsNmae': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(newGoods);
      _cartList.add(CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString(); // json 数据转字符串
    // print('字符串》》》》》》》》》》》${cartString}');
    // print('字符串》》》》》》》》》》》${_cartList}');

    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    _cartList = [];

    print('清空完成----------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString('cartInfo'); // 持久化中获得字符串
    _cartList = []; // 把最终的结果先设置为空 list

    if (cartString == null) {
      _cartList = []; // 如果持久化内没有数据 那么就还是空的 list
    } else {
      // 声明临时的变量
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        _cartList
            .add(CartInfoModel.fromJson(item)); // json 转成对象，加入到 _cartList 中
      });
    }

    // print(_cartList);

    notifyListeners(); // 通知
  }
}