import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:kk_weather/utils/commonHttp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _location = '';
  Map todayWeather = {};
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
    print(statuses[Permission.storage]);

    if (await Permission.location.request().isGranted) {
      checkPosition();
    }
  }

  void checkPosition() async {
    if (await Permission.location.isGranted) {
      final location = await AmapLocation.instance.fetchLocation();
      print(location);
      setState(() {
        _location = location.toString();
      });
      getWeather();
    }
  }

  Future<void> getWeather() async {
    await Ajax.doAjax(
        context: context,
        method: HTTP_METHOD.GET,
        uri: '',
        paramMap: {
          'version': 'v6',
          'appid': '64458634',
          'appsecret': 'SXXm9Q0z',
          'city': '铜陵',
        },
        callBack: (response, result) async {
          if (this.mounted) {
            setState(() {
              todayWeather = result;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      backgroundColor: Color(0xff5B96EF),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xff5B96EF),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(400),
              color: Colors.white,
              child: Column(
                children: <Widget>[],
              ),
            ),
            Text('$todayWeather'),
          ],
        ),
        onRefresh: getWeather,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getWeather();
        },
      ),
    );
  }
}
