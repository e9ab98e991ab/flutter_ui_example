import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui_example/app/FlutterRoute.dart';
import 'package:flutter_ui_example/app/flutter_application.dart';
import 'package:flutter_ui_example/app/theme_controller.dart';
import 'package:flutter_ui_example/constants.dart';
import 'package:flutter_ui_example/langure/langure.dart';
import 'package:flutter_ui_example/my_app_routes.dart';
import 'package:flutter_ui_example/my_app_settings.dart';
import 'package:flutter_ui_example/themes.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mmkv/mmkv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appApplication();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThremeController>(
      init: ThremeController(),
      builder: (controller) {
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: () => GetMaterialApp(
              title: '家有课堂',
              themeMode: ThemeMode.system,
              initialRoute: FlutterRoute.splash_page,
              getPages: FlutterRoute.routes,
              translations: Langure(),
              // locale: Get.deviceLocale
              locale: const Locale('zh', 'CN'),
              // translations will be displayed in that locale
              fallbackLocale: const Locale('zh', 'CN'),
              // specify the fallback locale in case an invalid locale is selected.
              theme: controller.isDark
                  ? controller.ktDarkThemeData
                  : controller.ktLightThemeData,
              home: MainMaterialApp(),
            ));
      },
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  MainMaterialApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FlutterAppSettings>.value(
      value: FlutterAppSettings(),
      child:
      MaterialApp(
        title: APP_NAME,
        routes: kAppRoutingTable,
      ),
    );
  }
}
