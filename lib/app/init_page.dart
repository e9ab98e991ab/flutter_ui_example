//****************************
// Copyright (C),视游互动-家有课堂
// 创建时间：2021/10/13 16:59
// 项目名称：kt720_flutter
// @author 赵强
// @version 1.0
// 文件名称：init_page
// 类说明：
//***************************/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_example/app/FlutterRoute.dart';
import 'package:get/get.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(FlutterRoute.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:FlutterLogo(size: 100)
      ),
    );
  }
}
