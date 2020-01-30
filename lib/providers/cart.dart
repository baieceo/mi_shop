/*
 * @Author: your name
 * @Date: 2020-01-30 20:36:26
 * @LastEditTime : 2020-01-30 22:58:08
 * @LastEditors  : Please set LastEditors
 * @Description: cart provider
 * @FilePath: \mi_shop\lib\providers\cart.dart
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]'; // 购物车数据持久化

  // 保存方法
  save(String goodsId, String goodsName, int count, double price,
      String images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 获取缓存数据
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast(); // temp 转 list
    bool isHas = false; // 商品是否存在标识
    int index = 0; // 循环索引

    // 判断商品是否存在，存在则加 1
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        isHas = true;
      }

      index++;
    });

    // 不存在则加入列表
    if (!isHas) {
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'images': images,
      });
    }

    cartString = json.encode(tempList).toString();

    print('加入购物车成功');
    print(cartString);

    // 持久化购物车数据
    prefs.setString('cartInfo', cartString);

    notifyListeners(); // 通知监听者
  }

  // 清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('cartInfo');

    print('清空购物车成功');

    notifyListeners(); // 通知监听者
  }
}
