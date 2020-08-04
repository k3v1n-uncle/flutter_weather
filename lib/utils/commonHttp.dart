//Ajax工具
import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:kk_weather/utils/server.dart';

enum HTTP_METHOD { GET, POST }

class Ajax {
  //仅用在无需判断权限的AJAX请求上
  static Future doAjax(
      {@required uri,
      @required BuildContext context,
      HTTP_METHOD method: HTTP_METHOD.GET,
      @required Function callBack,
      paramMap: const {},
      json: false,
      headers: const {}}) async {
    Dio _dio = Dio();

    ///忽略安全证书
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) {
//        return true;
//      };
//    };

    var transParamMap = {};
    var data;
    paramMap.forEach((key, value) {
      if (value == 'null' || value == null) {
        value = '';
      }
      transParamMap.putIfAbsent(key.toString(), () => value);
    });

    Random random = Random();
    var randInt = random.nextInt(999999);
    _dio.options.baseUrl = CommonApi.httpUri;
    _dio.options.connectTimeout = 15000; //5s
    _dio.options.receiveTimeout = 10000;

    Response response;
    try {
      if (method == HTTP_METHOD.GET) {
        var baselocalUrl = CommonApi.httpUri + uri + '?randInt=$randInt';
        transParamMap.forEach((key, value) {
          baselocalUrl += '&' + key + '=' + value.toString();
        });
        print('url:' + baselocalUrl);
        print('transParamMap:' + transParamMap.toString());
        response = await _dio.get(
          baselocalUrl,
          queryParameters: {},
          options: Options(
            headers: {},
            contentType: Headers.formUrlEncodedContentType,
          ),
        );
        data = response.data;
        print(data);
      } else {
        var baselocalUrl = CommonApi.httpUri + uri;
        print('url:' + baselocalUrl);
        print('formData:' + transParamMap.toString());
        response = await _dio.post(
          uri,
          data: transParamMap,
          options: Options(
            headers: {},
            contentType: Headers.formUrlEncodedContentType,
          ),
        );
        data = response.data;
        print(data);
      }
      callBack(response, data);
    } on DioError catch (e) {
      print('e:::::::::::::::$e');
      return e;
    }
  }
}
