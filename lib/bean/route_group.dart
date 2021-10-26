import 'package:flutter/material.dart';
import 'package:flutter_ui_example/my_route.dart';

class MyRouteGroup {
  const MyRouteGroup(
      {required this.groupName, required this.icon, required this.routes});
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;
}