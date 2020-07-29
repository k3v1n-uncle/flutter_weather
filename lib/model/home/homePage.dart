import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:kk_weather/utils/commonHttp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String locationStr = '';
  Map todayWeather = {};

  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    AmapLocation.instance.dispose();
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
        locationStr = location.toString();
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
          'version': 'v62',
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
      backgroundColor: Color(0xff004E95),
//      appBar: AppBar(
//        title: Text(''),
//        backgroundColor: Color(0xff5B96EF),
//        elevation: 0.0,
//        centerTitle: true,
//      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6B4AFF), Color(0xff78C5F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(25),
            ),
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              ///地点
              Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '铜陵',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              ///日期
              Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${todayWeather['update_time'].toString().substring(5, 10)} ${todayWeather['week']} ${todayWeather['update_time'].toString().substring(10, 16)}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),

              ///温度
              Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      width: ScreenUtil().setWidth(80),
                      image: AssetImage(
                          'assets/images/cake/${todayWeather['wea_img']}.png'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${todayWeather['tem']}°',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(100),
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              ///空气湿度
              Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${todayWeather['tem1']}°/${todayWeather['tem2']}° 空气湿度：${todayWeather['humidity']}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),

              ///空气提示
              Container(
                width: ScreenUtil().setWidth(400),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(50),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Text(
                      '${todayWeather['air_tips']}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              ///雾霾
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                height: ScreenUtil().setHeight(200),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff8EC5FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${todayWeather['air_level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'AQI：${todayWeather['air']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'PM2.5：${todayWeather['air_pm25']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${todayWeather['win']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '风力：${todayWeather['win_speed']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '风速：${todayWeather['win_meter']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///24小时天气
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                height: ScreenUtil().setHeight(200),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff8EC5FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${todayWeather['air_level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'AQI：${todayWeather['air']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'PM2.5：${todayWeather['air_pm25']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(350),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${todayWeather['win']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '风力：${todayWeather['win_speed']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '风速：${todayWeather['win_meter']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text('$todayWeather'),
            ],
          ),
          onRefresh: getWeather,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getWeather();
        },
      ),
    );
  }
}
