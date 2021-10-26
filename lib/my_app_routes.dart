// This file declares routes of this app, in particular it declares the
// "structure" of the group of example routes, in a const List<Tuple2> object.
// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_ui_example/about.dart';
import 'package:flutter_ui_example/constants.dart';
import 'package:flutter_ui_example/home_page.dart';
import 'package:flutter_ui_example/modular/animation/animation_animated_widget_ex.dart';
import 'package:flutter_ui_example/modular/animation/animation_low_level_ex.dart';
import 'package:flutter_ui_example/modular/widgets/widgets_icon_ex.dart';
import 'package:flutter_ui_example/modular/widgets/widgets_text_ex.dart';
import 'package:flutter_ui_example/my_route.dart';

const kHomeRoute = MyRoute(
  sourceFilePath: 'lib/modular/home.dart',
  title: APP_NAME,
  routeName: Navigator.defaultRouteName,
  child: MyHomePage(),
);

const kAboutRoute = MyRoute(
  sourceFilePath: 'lib/modular/about.dart',
  title: 'About',
  links: {
    'Doc': 'https://docs.flutter.io/flutter/material/showAboutDialog.html'
  },
  child: MyAboutRoute(),
);

// The structure of app's navigation drawer items is a 2-level menu, its schema
// is the following:
// [ MyRouteGroup{
//        groupName: group1_name,
//        icon: group1_icon,
//        routes: [route1, route2, ...]
//   },
//   MyRouteGroup{
//        groupName: group2_name,
//        icon: group2_icon,
//        routes: [route1, route2, ...]
//   },
//   ...
// ]
class MyRouteGroup {
  const MyRouteGroup(
      {required this.groupName, required this.icon, required this.routes});
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;
}

const kMyAppRoutesBasic = <MyRouteGroup>[
  MyRouteGroup(
    groupName: 'Widgets',
    icon: Icon(Icons.extension),
    routes: <MyRoute>[
      MyRoute(
        child: IconExample(),
        sourceFilePath: 'lib/modular/widgets/widgets_icon_ex.dart',
        title: 'Icon',
      ),
      MyRoute(
        child: TextExample(),
        sourceFilePath: 'lib/modular/widgets/widgets_text_ex.dart',
        title: 'Text',
      ),
    ],
  ),
];

const kMyAppRoutesAdvanced = <MyRouteGroup>[
  MyRouteGroup(
    groupName: 'Animation (advanced)',
    icon: Icon(Icons.movie_filter),
    routes: <MyRoute>[
      MyRoute(
        child: LowLevelAnimationExample(),
        sourceFilePath: 'lib/modular/animation/animation_low_level_ex.dart',
        title: 'Low level animation',
        description:
            'Implement animation using low-level Animations, AnimationControllers and Tweens.',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial',
          'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
        },
      ),
      MyRoute(
        child: AnimatedWidgetExample(),
        sourceFilePath: 'lib/modular/animation/animation_animated_widget_ex.dart',
        title: 'AnimatedWidget',
        description: 'Easier animtation without addListener() and setState()',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial#simplifying-with-animatedwidget',
          'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
        },
      ),
    ],
  ),
];

final kAllRouteGroups = <MyRouteGroup>[
  ...kMyAppRoutesBasic,
  ...kMyAppRoutesAdvanced,
];

final kAllRoutes = <MyRoute>[
  ...kAllRouteGroups.expand((group) => group.routes),
];

final kRouteNameToRoute = <String, MyRoute>{
  for (final route in kAllRoutes) route.routeName: route
};

final kRouteNameToRouteGroup = <String, MyRouteGroup>{
  for (final group in kAllRouteGroups)
    for (final route in group.routes) route.routeName: group
};

// This app's root-level routing table.
final kAppRoutingTable = <String, WidgetBuilder>{
  Navigator.defaultRouteName: (context) => kHomeRoute,
  kAboutRoute.routeName: (context) => kAboutRoute,
  for (MyRoute route in kAllRoutes) route.routeName: (context) => route,
};
