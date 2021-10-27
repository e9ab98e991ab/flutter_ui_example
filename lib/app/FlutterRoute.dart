

import 'package:flutter_ui_example/app/init_page.dart';
import 'package:flutter_ui_example/app/home_page.dart';
import 'package:flutter_ui_example/app/webview_page.dart';
import 'package:flutter_ui_example/main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class FlutterRoute{
  static const String splash_page = '/splashPage';
  static const String home = '/home';
  static const String webview = '/webview';
  static const String videodetail = '/videodetail';


  static final routes = [
    GetPage(
        name: FlutterRoute.home,
        page: () =>  MainMaterialApp(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: FlutterRoute.splash_page,
        page: () => const InitPage(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: FlutterRoute.webview,
        page: () =>const WebviewPage(),
        transition: Transition.rightToLeft
    )
  ];
}