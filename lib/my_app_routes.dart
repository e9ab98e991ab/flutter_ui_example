// This file declares modular of this app, in particular it declares the
// "structure" of the group of example modular, in a const List<Tuple2> object.
// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_ui_example/about.dart';
import 'package:flutter_ui_example/bean/route_group.dart';
import 'package:flutter_ui_example/constants.dart';
import 'package:flutter_ui_example/app/home_page.dart';
import 'package:flutter_ui_example/modular/animation/animation_animated_widget_ex.dart';
import 'package:flutter_ui_example/modular/animation/animation_low_level_ex.dart';
import 'package:flutter_ui_example/modular/search/search_bar_view_ex.dart';
import 'package:flutter_ui_example/modular/splash/splash_page.dart';
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
  MyRouteGroup(
    groupName: 'search',
    icon: Icon(Icons.search),
    routes: <MyRoute>[
      MyRoute(
        child: Search(),
        sourceFilePath: 'lib/modular/search/search_bar_view_ex.dart',
        title: 'search_bar_view_ex',
      ),
    ],
  ),
  MyRouteGroup(
    groupName: 'Splash',
    icon: Icon(Icons.stay_primary_landscape_sharp),
    routes: <MyRoute>[
      MyRoute(
        child: SplashPage(),
        sourceFilePath: 'lib/modular/splash/splash_page.dart',
        title: 'splash_page',
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
        },
      ),
      MyRoute(
        child: AnimatedWidgetExample(),
        sourceFilePath:
            'lib/modular/animation/animation_animated_widget_ex.dart',
        title: 'AnimatedWidget',
        description: 'Easier animtation without addListener() and setState()',
        links: {
          'Tutorial':
              'https://flutter.dev/docs/development/ui/animations/tutorial#simplifying-with-animatedwidget',
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
