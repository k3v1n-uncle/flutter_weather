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
  Location _location;
  Map todayWeather = {
    "cityid": "101221301",
    "date": "2020-07-31",
    "week": "星期五",
    "update_time": "09:21",
    "city": "铜陵",
    "cityEn": "tongling",
    "country": "中国",
    "countryEn": "China",
    "wea": "阴",
    "wea_img": "yin",
    "tem": "30",
    "tem1": "34",
    "tem2": "27",
    "win": "北风",
    "win_speed": "1级",
    "win_meter": "小于12km\/h",
    "humidity": "81%",
    "visibility": "11.5km",
    "pressure": "1007",
    "air": "59",
    "air_pm25": "28",
    "air_level": "良",
    "air_tips": "空气好，可以外出活动，除极少数对污染物特别敏感的人群以外，对公众没有危害！",
    "alarm": {"alarm_type": "", "alarm_level": "", "alarm_content": ""},
    "wea_day": "多云",
    "wea_day_img": "yun",
    "wea_night": "多云",
    "wea_night_img": "yun",
    "sunrise": "05:24",
    "sunset": "19:05",
    "hours": [
      {
        "hours": "现在",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "30",
        "win": "东南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "10:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "31",
        "win": "南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "11:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "32",
        "win": "西南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "12:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "13:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "14:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "15:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西北风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "16:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西北风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "17:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "33",
        "win": "西北风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "18:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "32",
        "win": "东北风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "19:00",
        "wea": "阴转多云",
        "wea_img": "yun",
        "tem": "30",
        "win": "东风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "20:00",
        "wea": "阴转多云",
        "wea_img": "yun",
        "tem": "29",
        "win": "东南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "21:00",
        "wea": "阴转多云",
        "wea_img": "yun",
        "tem": "29",
        "win": "东南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "22:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "29",
        "win": "东南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "23:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "29",
        "win": "东南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "08\/01",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "01:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "02:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "西南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "03:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "04:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "05:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "27",
        "win": "西南风",
        "win_speed": "1级",
        "aqi": "优"
      },
      {
        "hours": "06:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "28",
        "win": "南风",
        "win_speed": "2级",
        "aqi": "优"
      },
      {
        "hours": "07:00",
        "wea": "多云",
        "wea_img": "yun",
        "tem": "29",
        "win": "南风",
        "win_speed": "2级",
        "aqi": "优"
      }
    ],
    "aqi": {
      "air": "59",
      "air_level": "良",
      "air_tips": "空气好，可以外出活动，除极少数对污染物特别敏感的人群以外，对公众没有危害！",
      "pm25": "28",
      "pm25_desc": "优",
      "pm10": "68",
      "pm10_desc": "良",
      "o3": "22",
      "o3_desc": "优",
      "no2": "29",
      "no2_desc": "优",
      "so2": "11",
      "so2_desc": "优",
      "kouzhao": "无需戴口罩",
      "waichu": "适宜外出",
      "kaichuang": "适宜开窗",
      "jinghuaqi": "关闭净化器"
    },
    "zhishu": {
      "chuanyi": {"level": "天气炎热", "tips": "建议穿薄型T恤短裤等夏装。"},
      "daisan": {"level": "无需带伞", "tips": "外出时无需带雨伞。"},
      "ganmao": {"level": "少发感冒", "tips": "发生感冒机率较低。"},
      "chenlian": {"level": "较适宜晨练", "tips": "气象条件会对晨练影响不大。"},
      "ziwaixian": {"level": "紫外线强", "tips": "外出尽量涂抹高倍数防晒霜。"},
      "liangshai": {"level": "适宜晾晒", "tips": "天气不错，适宜晾晒衣物。"},
      "kaiche": {"level": "适宜开车", "tips": "天气很好，适宜正常行驶。"},
      "xiche": {"level": "适宜洗车", "tips": "天气较好，适合擦洗汽车。"},
      "lvyou": {"level": "较不适宜旅游", "tips": "天气较差，不建议旅游。"},
      "diaoyu": {"level": "较适宜钓鱼", "tips": "气象条件对钓鱼影响不大。"}
    }
  };

  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    AmapLocation.dispose();
    super.dispose();
  }

  ///获取定位权限
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

  ///获取定位
  void checkPosition() async {
    if (await Permission.location.isGranted) {
      _location = await AmapLocation.fetchLocation();
      print('locationlocationlocation');
      print(_location);
      getWeather();
    }
  }

  ///获取天气信息
  Future<void> getWeather() async {
    await Ajax.doAjax(
        context: context,
        method: HTTP_METHOD.GET,
        uri: '',
        paramMap: {
          'version': 'v62',
          'appid': '64458634',
          'appsecret': 'SXXm9Q0z',
          'city': _location.city.substring(0, _location.city.length - 1),
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
            padding: EdgeInsets.only(
              right: ScreenUtil().setWidth(25),
              left: ScreenUtil().setWidth(25),
              bottom: ScreenUtil().setHeight(50),
            ),
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              ///地点
              Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${_location.city}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
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
                      '${todayWeather['date'].toString().substring(5, 10)} ${todayWeather['week']} ${todayWeather['update_time']}',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image(
                          width: ScreenUtil().setWidth(80),
                          image: AssetImage(
                              'assets/images/cake/${todayWeather['wea_img']}.png'),
                        ),
                        Text(
                          '${todayWeather['wea']}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
                  vertical: ScreenUtil().setHeight(20),
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
                            '空气指数',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${todayWeather['aqi']['air_level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'AQI：${todayWeather['aqi']['air']}',
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
                            'PM2.5',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${todayWeather['aqi']['pm25_desc']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'PM2.5：${todayWeather['aqi']['pm25']}',
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
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                ),
                child: Text(
                  '24小时天气',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                height: ScreenUtil().setHeight(350),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff8EC5FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (var item in todayWeather['hours'])
                      Container(
                        width: ScreenUtil().setWidth(200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${item['hours']}',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Colors.white,
                              ),
                            ),
                            Image(
                              width: ScreenUtil().setWidth(60),
                              image: AssetImage(
                                  'assets/images/cake/${item['wea_img']}.png'),
                            ),
                            Text(
                              '${item['wea']}',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '温度：${item['tem']}°',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '风力：${item['win_speed']}',
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

              ///指数建议
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                ),
                child: Text(
                  '生活贴士',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(700),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                  horizontal: ScreenUtil().setWidth(30),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff8EC5FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['chuanyi']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['chuanyi']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['daisan']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['daisan']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['ganmao']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['ganmao']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['chenlian']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['chenlian']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['ziwaixian']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['ziwaixian']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['liangshai']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['liangshai']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['kaiche']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['kaiche']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['xiche']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['xiche']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['lvyou']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['lvyou']['tips']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${todayWeather['zhishu']['diaoyu']['level']}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${todayWeather['zhishu']['diaoyu']['tips']}',
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
            ],
          ),
          onRefresh: getWeather,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkPosition();
        },
      ),
    );
  }
}
