import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/auth/login.dart';
import 'package:sahami_app/views/screens/home/main_view.dart';
import 'package:sahami_app/views/screens/home/statistics_view.dart';
import 'package:sahami_app/views/screens/manage/customer/customer_add_address_view.dart';
import 'package:sahami_app/views/screens/manage/customer/customer_detail_view.dart';
import 'package:sahami_app/views/screens/splash_view.dart';
import '../views/screens/manage/customer/customer_create_view.dart';

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

  static const String CUSTOMER_CREATE_VIEW_ROUTE = "/CUSTOMER_CREATE_VIEW_ROUTE";
  static const String CUSTOMER_ADD_ADDRESS_VIEW_ROUTE = "/CUSTOMER_ADD_ADDRESS_VIEW_ROUTE";
  static const String CUSTOMER_DETAIL_VIEW_ROUTE = "/CUSTOMER_DETAIL_VIEW_ROUTE";

  static const String LOGIN_VIEW_ROUTE = "/LOGIN_VIEW_ROUTE";



  String initialRoute() => SPLASH_PROGRESS_ROUTE;

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch(settings.name) {
      case SPLASH_PROGRESS_ROUTE:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case LOGIN_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const MainView());
      case STATISTICS_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const StatisticsView());
      case CUSTOMER_CREATE_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CustomerCreateView());
      case CUSTOMER_ADD_ADDRESS_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CustomerAddAddressView());
      case CUSTOMER_DETAIL_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CustomerDetailView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }

  void navigationToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, HOME_ROUTE);
  }
  void navigationToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LOGIN_VIEW_ROUTE);
  }
  void navigationToCustomerCreateScreen(BuildContext context) {
    Navigator.pushNamed(context, CUSTOMER_CREATE_VIEW_ROUTE);
  }
  void navigationToCustomerAddAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, CUSTOMER_ADD_ADDRESS_VIEW_ROUTE);
  }

  void navigationToCustomerDetailScreen(BuildContext context) {
    Navigator.pushNamed(context, CUSTOMER_DETAIL_VIEW_ROUTE);
  }
}