import 'package:backdrop/backdrop.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_example/about.dart';
import 'package:flutter_ui_example/app/FlutterRoute.dart';
import 'package:flutter_ui_example/app/theme_controller.dart';
import 'package:flutter_ui_example/constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';
import './my_app_settings.dart';


import 'app/my_route_search_delegate.dart';

class MyRoute extends StatelessWidget {
  static const _kFrontLayerMinHeight = 128.0;

  // Path of source file (relative to project root). The file's content will be
  // shown in the "Code" tab.
  final String sourceFilePath;

  // Actual content of the example.
  final Widget child;

  // Title shown in the route's appbar. By default just returns routeName.
  final String? _title;

  // A short description of the route. If not null, will be shown as subtitle in
  // the home page list tile.
  final String description;

  // Returns a set of links {title:link} that are relative to the route. Can put
  // documention links or reference video/article links here.
  final Map<String, String> links;

  // Route name of a page, if missing, use ${child.runtimeType}.
  final String? _routeName;
  final Iterable<PlatformType> supportedPlatforms;

  const MyRoute({
    Key? key,
    required this.sourceFilePath,
    required this.child,
    String? title,
    this.description = '',
    this.links = const <String, String>{},
    String? routeName,
    this.supportedPlatforms = PlatformType.values,
  })  : _title = title,
        _routeName = routeName,
        super(key: key);

  String get routeName =>
      this._routeName ?? '/${this.child.runtimeType.toString()}';

  String get title => _title ?? this.routeName;

  @override
  Widget build(BuildContext context) {
    final appbarLeading =
        (kIsOnMobile || this.routeName == Navigator.defaultRouteName)
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              );
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(this.title),
        ),
        actions: _getAppbarActions(context),
        automaticallyImplyLeading: false,
        leading: appbarLeading,
      ),
      headerHeight: _kFrontLayerMinHeight,
      frontLayerBorderRadius: BorderRadius.zero,
      frontLayer: Builder(
        builder: (BuildContext context) =>
            routeName == Navigator.defaultRouteName
                ? this.child
                : WidgetWithCodeView(
                    sourceFilePath: this.sourceFilePath,
                    codeLinkPrefix: '$GITHUB_URL/blob/main',
                    child: this.child,
                  ),
      ),
      backLayer: _getBackdropListTiles(),
    );
  }

  List<Widget> _getAppbarActions(BuildContext context) {
    final settings = Provider.of<FlutterAppSettings>(context);
    return <Widget>[
      const BackdropToggleButton(),
      if (this.routeName == Navigator.defaultRouteName)
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            await showSearch<String>(
              context: context,
              delegate: MyRouteSearchDelegate(),
            );
          },
        ),
      if (this.routeName != Navigator.defaultRouteName)
        settings.starStatusOfRoute(this.routeName),
      if (this.links.isNotEmpty)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink in this.links.entries)
                PopupMenuItem(
                  child: ListTile(
                    title: Text(titleAndLink.key),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      tooltip: titleAndLink.value,
                      onPressed: () =>
                      Get.toNamed(FlutterRoute.webview, arguments: {"url":titleAndLink.value}) ,
                    ),
                    onTap: () => Get.toNamed(FlutterRoute.webview, arguments: {"url":titleAndLink.value}) ,
                  ),
                )
            ];
          },
        ),
    ];
  }

  ListView _getBackdropListTiles() {
    return ListView(
      padding: const EdgeInsets.only(bottom: _kFrontLayerMinHeight),
      children: <Widget>[
        ListTile(
          leading: kAppIcon,
          title: const Text(APP_NAME),
          subtitle: const Text(APP_VERSION),
        ),
        ...MyAboutRoute.kAboutListTiles,
        Consumer<FlutterAppSettings>(builder: (context, FlutterAppSettings settings, _) {
          return ListTile(
            onTap: () {},
            leading: Icon(Icons.nightlight_round),
            title: Text('Dark mode: ${settings.isDarkMode ? 'on' : 'off'}'),
            trailing: DayNightSwitcherIcon(
              isDarkModeEnabled: settings.isDarkMode,
              onStateChanged: (bool value) => {
                Get.find<ThremeController>().changeTheme(value)
              },
            ),
          );
        }),
      ],
    );
  }
}
