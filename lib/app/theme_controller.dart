//****************************
// Copyright (C),视游互动-家有课堂
// 创建时间：2021年 08月23日 11:49
// 项目名称：kt720_flutter  
// @author 赵强
// @version 1.0
// 文件名称：KtThremeController  
// 类说明：主题控制
//***************************/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';

class ThremeController extends GetxController{
  //创建Dark ThemeData对象
  final ThemeData ktDarkThemeData = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.orange,
      // 主要部分背景颜色（导航和tabBar等）
      scaffoldBackgroundColor: Colors.black,
      //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.orange, fontSize: 15),
          headline1: TextStyle(color: Colors.yellow, fontSize: 15)),
      appBarTheme:
      const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)));

//创建light ThemeData对象
  final ThemeData ktLightThemeData = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.orange,
      // 主要部分背景颜色（导航和tabBar等）
      scaffoldBackgroundColor: Colors.white,
      //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.orange, fontSize: 15),
          headline1: TextStyle(color: Colors.blue, fontSize: 15)),
      appBarTheme:
      const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)));

  var _isDark=false;
  get isDark{
    _isDark= MMKV.defaultMMKV().decodeBool("theme");
    return _isDark;
  }

  void changeTheme(bool isdark){
    _isDark=isdark;
    MMKV.defaultMMKV().encodeBool("theme", isdark);
    Get.changeTheme(_isDark?ktDarkThemeData:ktLightThemeData);
    update();
  }

}

