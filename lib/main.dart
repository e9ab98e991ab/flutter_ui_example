import 'package:flutter/material.dart';
import 'package:flutter_ui_example/constants.dart';
import 'package:flutter_ui_example/my_app_routes.dart';
import 'package:flutter_ui_example/my_app_settings.dart';
import 'package:flutter_ui_example/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  runApp(FlutterApplication(preferences: sharedPref));
}

class FlutterApplication extends StatelessWidget {
  final SharedPreferences preferences;
  const FlutterApplication( {Key? key, required this.preferences}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAppSettings>.value(
      value: MyAppSettings(preferences),
      child: const MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: Provider.of<MyAppSettings>(context).isDarkMode
          ? kDarkTheme
          : kLightTheme,
      // home: const HomePage(),
      routes: kAppRoutingTable,
    );
  }
}
