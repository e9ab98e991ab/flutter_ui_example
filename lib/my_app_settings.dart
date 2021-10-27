import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui_example/bean/route_group.dart';
import 'package:flutter_ui_example/my_app_routes.dart';
import 'package:flutter_ui_example/my_route.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterAppSettings extends ChangeNotifier {
  static const _kDarkModeKey = 'DARK_MODE';
  static const _kSearchHistoryKey = 'SEARCH_HISTORY';
  static const _kBookmarkedRoutesKey = 'BOOKMARKED_ROUTES';
  static final _kRoutenameToRouteMap = {
    for (MyRoute route in kAllRoutes) route.routeName: route
  };

  SharedPreferences? _pref =null;

  FlutterAppSettings() {
    SharedPreferences.getInstance().then((value) => {
      _pref = value,
      name()
    });
  }

  void name() {
    if (_pref?.getStringList(_kKnownRoutesKey) == null) {
      final allrouteNames = _kRoutenameToRouteMap.keys.toList()
        ..add(kAboutRoute.routeName);
      _pref?.setStringList(_kKnownRoutesKey, allrouteNames);
    }
  }

  bool get isDarkMode => _pref?.getBool(_kDarkModeKey) ?? false;

  // ignore:avoid_positional_boolean_parameters
  void setDarkMode(bool val) {
    _pref?.setBool(_kDarkModeKey, val);
    notifyListeners();
  }

  /// The list of route names in search history.
  List<String> get searchHistory =>
      _pref?.getStringList(_kSearchHistoryKey) ?? [];

  void addSearchHistory(String routeName) {
    List<String> history = this.searchHistory;
    history.remove(routeName);
    history.insert(0, routeName);
    if (history.length >= 10) {
      history = history.take(10).toList();
    }
    _pref?.setStringList(_kSearchHistoryKey, history);
  }

  List<String> get starredRoutenames =>
      _pref?.getStringList(_kBookmarkedRoutesKey) ?? [];

  List<MyRoute> get starredRoutes => [
    for (String routename in this.starredRoutenames)
      if (_kRoutenameToRouteMap[routename] != null)
        _kRoutenameToRouteMap[routename]!
  ];

  // Returns a widget showing the star status of one demo route.
  Widget starStatusOfRoute(String routeName) {
    return IconButton(
      tooltip: ('bookmarks'.tr),
      icon: Icon(
        this.isStarred(routeName) ? Icons.star : Icons.star_border,
        color: this.isStarred(routeName) ? Colors.yellow : Colors.grey,
      ),
      onPressed: () => this.toggleStarred(routeName),
    );
  }

  bool isStarred(String routeName) => starredRoutenames.contains(routeName);

  void toggleStarred(String routeName) {
    final staredRoutes = this.starredRoutenames;
    if (isStarred(routeName)) {
      staredRoutes.remove(routeName);
    } else {
      staredRoutes.add(routeName);
    }
    final dedupedStaredRoutes = Set<String>.from(staredRoutes).toList();
    _pref?.setStringList(_kBookmarkedRoutesKey, dedupedStaredRoutes);
    notifyListeners();
  }

  // Used to decide if an example route is newly added. We will show a red dot
  // for newly added routes.
  static const _kKnownRoutesKey = 'KNOWN_ROUTES';
  bool isNewRoute(String routeName) =>
      !(_pref?.getStringList(_kKnownRoutesKey)?.contains(routeName) ?? false);

  void markRouteKnown(String routeName) {
    if (isNewRoute(routeName)) {
      final knowRoutes = _pref?.getStringList(_kKnownRoutesKey)?..add(routeName);
      _pref?.setStringList(_kKnownRoutesKey, knowRoutes ?? []);
      notifyListeners();
    }
  }

  // Returns the number of new example routes in this group.
  int numNewRoutes(MyRouteGroup group) {
    return group.routes.where((route) => isNewRoute(route.routeName)).length;
  }
}
