//Ajax工具
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:kk_weather/utils/server.dart';
import 'package:kk_weather/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString('deviceId');

//    print(token);
//    if (clientUserId == 'null' || clientUserId == null) {
//      clientUserId = '';
//    }
//    if (token == 'null' || token == null) {
//      token = '';
//    }
    paramMap.forEach((key, value) {
      if (value == 'null' || value == null) {
        value = '';
      }
      transParamMap.putIfAbsent(key.toString(), () => value);
    });

    Random random = Random();
    var randInt = random.nextInt(999999);
//    transParamMap.putIfAbsent('randInt', () => randInt.toString());

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

//  //上传文件
//  static Future<Map> upload(
//      {@required uri,
//      @required BuildContext context,
//      @required File source,
//      method: HTTP_METHOD.POST,
//      paramMap: const {},
//      headers: const {}}) async {
////    print('paramMapparamMapparamMapparamMap');
////    print(paramMap);
//    Dio _dio = Dio();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String uid = prefs.getString('UserId');
////    String wid = prefs.getString('pid');
//    String token = prefs.getString('Token');
//    _dio.options.baseUrl = CommonApi.httpUri;
//    _dio.options.connectTimeout = 15000; //5s
//    _dio.options.receiveTimeout = 15000;
//
//    String path = source.path;
//    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
////    FormData formData = new FormData.fromMap(
////        {"file": new UploadFileInfo(new File(path), name)});
//
//    FormData formData = FormData.fromMap({
//      'file': await MultipartFile.fromFile(
//        path,
//        filename: name,
//      ),
//      'fileType': paramMap['type'],
//    });
////    print(source.path);
////    print(uri);
////    print(token);
////    print(formData.toString());
////    print(formData.files.toString());
//    NativeProgressHud.showWaitingWithText("图片上传中...");
//    try {
//      Response response = await _dio.post(
//        uri,
//        data: formData,
//        options: Options(
//          headers: {
//            "token": token,
////            "AuthenticationToken": token,
//          },
//          contentType: "multipart/form-data", // or ResponseType.JSON
//        ),
//      );
//      NativeProgressHud.hideWaiting();
////      print('&&&&&&&&&&&&&&&&&&&&&&&');
////      print(response);
////      print('&&&&&&&&&&&&&&&&&&&&&&&');
//      return response.data;
//    } on DioError catch (e) {
//      NativeProgressHud.hideWaiting();
//      showFlutterToast('$e', 2);
////      print(':::::::::::::::::::::::::::::::::::::::::::::::::$e');
//      return {};
//    }
//  }
}
