



import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static DateTime? _lastPressedAt =null; //上次点击时间
  static Future<bool> exitApp() async{
    if (_lastPressedAt == null ||DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();
      Fluttertoast.showToast(msg:"在按一次退出",toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }
}

