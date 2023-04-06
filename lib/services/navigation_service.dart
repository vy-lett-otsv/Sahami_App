import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/home/home_view.dart';
import 'package:sahami_app/views/screens/home/main_view.dart';
import 'package:sahami_app/views/screens/home/statistics_view.dart';
import 'package:sahami_app/views/screens/manage/product/product_create_view.dart';
import 'package:sahami_app/views/screens/home/product_view.dart';
import 'package:sahami_app/views/screens/splash_view.dart';

class NavigationServices {
  static NavigationServices _instance = const NavigationServices._internal();
  static NavigationServices get instance => _instance;
  const NavigationServices._internal();

  factory NavigationServices() {
    if(instance == null) {
      _instance = const NavigationServices._internal();
    }
    return _instance;
  }

  static const String SPLASH_PROGRESS_ROUTE = "/SPLASH_PROGRESS_ROUTE";
  static const String HOME_ROUTE = "/HOME_ROUTE";
  static const String STATISTICS_VIEW_ROUTE = "/STATISTICS_VIEW_ROUTE";
  static const String PRODUCT_HOME_VIEW_ROUTE = "/PRODUCT_HOME_VIEW_ROUTE";
  static const String PRODUCT_CREATE_VIEW_ROUTE = "/PRODUCT_CREATE_VIEW_ROUTE";

  String initialRoute() => SPLASH_PROGRESS_ROUTE;

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch(settings.name) {
      case SPLASH_PROGRESS_ROUTE:
        return MaterialPageRoute(builder: (_) => SplashView());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => MainView());
      case STATISTICS_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => StatisticsView());
      case PRODUCT_HOME_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => ProductView());
      case PRODUCT_CREATE_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => ProductCreateView());
      default:
        return MaterialPageRoute(builder: (_) => SplashView());
    }
  }

  void navigationToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, HOME_ROUTE);
  }
  void navigationToProductCreateScreen(BuildContext context) {
    Navigator.pushNamed(context, PRODUCT_CREATE_VIEW_ROUTE);
  }
}