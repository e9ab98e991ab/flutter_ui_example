import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_example/utils/utils.dart';

// ignore_for_file: constant_identifier_names

// 注意：当 APP_VERSION 改变时，记得也要更新 pubspec.yaml。
const APP_VERSION = 'v3.0.0';
const APP_NAME = 'Flutter UI Example';
final kAppIcon = Image.asset(Utils.getImgPath("launcher_icon"), height: 64.0, width: 64.0);
const APP_DESCRIPTION = '一个展示 Flutter 组件的应用程，并且可以查看代码视图 '
    '\n\nDeveloped by e9ab98e991ab.';
const GITHUB_URL = 'https://github.com/e9ab98e991ab/flutter_ui_example';
const AUTHOR_SITE = 'https://booksdoc.cn';

final kPlatformType = getCurrentPlatformType();
// Whether the app is running on mobile phones (Android/iOS)
final kIsOnMobile =
    {PlatformType.Android, PlatformType.iOS}.contains(kPlatformType);

/// ! Adapted from https://www.flutterclutter.dev/flutter/tutorials/how-to-detect-what-platform-a-flutter-app-is-running-on/2020/127/
enum PlatformType { Web, iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }

PlatformType getCurrentPlatformType() {
  // ! `Platform` is not available on web, so we must check web first.
  if (kIsWeb) {
    return PlatformType.Web;
  }

  if (Platform.isMacOS) {
    return PlatformType.MacOS;
  }

  if (Platform.isFuchsia) {
    return PlatformType.Fuchsia;
  }

  if (Platform.isLinux) {
    return PlatformType.Linux;
  }

  if (Platform.isWindows) {
    return PlatformType.Windows;
  }

  if (Platform.isIOS) {
    return PlatformType.iOS;
  }

  if (Platform.isAndroid) {
    return PlatformType.Android;
  }

  return PlatformType.Unknown;
}
