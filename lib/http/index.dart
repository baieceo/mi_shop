import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Http {
  static BaseOptions options = BaseOptions(
    baseUrl: 'https://m.mi.com/v1/',
    connectTimeout: 60000,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Referer': 'https://m.mi.com/'
    },
  );

  static Dio dio = Dio(options);

  static get({
    @required String path,
    Map<String, String> data = const {},
    options,
  }) async {
    try {
      Response response = await dio.get(path, queryParameters: addParam(data));

      return response.data;
    } on DioError catch (e) {
      formatError(e);
    }
  }

  static post({
    @required String path,
    Map<String, String> data = const {},
    options,
  }) async {
    try {
      Response response = await dio.post(path, queryParameters: addParam(data));

      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on DioError catch (e) {
      formatError(e);
    }
  }

  static jsonp({
    @required String path,
    Map<String, String> data = const {},
    Map<String, dynamic> callback,
  }) async {
    try {
      WordPair wordPair = new WordPair.random();
      String query = 'callback';
      String param = wordPair.toString();

      if (callback['query'] != null) {
        query = callback['query'];
      }

      if (callback['param'] != null) {
        param = callback['param'];
      }

      data[query] = param;

      Response response =
          await dio.get<String>(path, queryParameters: addParam(data));

      String result =
          response.data.replaceAll(param + '(', '').replaceAll(');', '');

      return json.decode(result);
    } on DioError catch (e) {
      formatError(e);
    }
  }

  static Map addParam(Map<String, String> data) {
    data['client_id'] = '180100031051';
    data['webp'] = '1';

    return data;
  }

  static void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print('连接超时');
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print('请求超时');
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print('响应超时');
    } else if (e.type == DioErrorType.RESPONSE) {
      print('出现异常');
    } else if (e.type == DioErrorType.CANCEL) {
      print('请求取消');
    } else {
      print('未知错误');
    }
  }
}
