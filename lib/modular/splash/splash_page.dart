import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_example/app/FlutterRoute.dart';
import 'package:flutter_ui_example/utils/app_util.dart';
import 'package:flutter_ui_example/utils/timer_util.dart';
import 'package:flutter_ui_example/utils/utils.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';

const String key_guide = 'key_guide';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil = TimerUtil(mTotalTime: 3 * 1000);
  MMKV mv = MMKV.defaultMMKV();
  final List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide1'),
  ];

  List<Widget> _bannerList = [];

  int _status = 0;
  int _count = 3;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    Timer(Duration(milliseconds: 3000), () {
      if (!mv.decodeBool(key_guide)) {
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: InkWell(
                  onTap: () {
                    mv.encodeBool(key_guide, true);
                    _goMain();
                  },
                  child: const CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _initSplash() {
    _doCountDown();
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Get.offAllNamed(FlutterRoute.home);
  }

  Widget _buildSplashBg() {
    return Image.asset(
      Utils.getImgPath('splash_bg'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  Widget _buildAdWidget() {
    return Offstage(
      offstage: !(_status == 1),
      child: InkWell(
        onTap: () {
          _goMain();
        },
        child: Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: Utils.getImgPath("splash_bg"),
            placeholder: (context, url) => _buildSplashBg(),
            errorWidget: (context, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          Offstage(
            offstage: !(_status == 2),
            child: _bannerList.isEmpty
                ? Container()
                : Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                      radius: 4.0,
                      padding: EdgeInsets.only(bottom: 30.0),
                      itemColor: Colors.black26,
                    ),
                    children: _bannerList),
          ),
          _buildAdWidget(),
          Offstage(
              offstage: !(_status == 1),
              child: Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text('跳过  $_count',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.white)),
                    decoration: BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(
                            width: 0.33, color: Color(0xffe5e5e5))),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}

