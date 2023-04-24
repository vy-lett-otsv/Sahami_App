import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/auth/login_view.dart';
import 'package:sahami_app/views/screens/auth/register_view.dart';
import 'package:sahami_app/views/screens/home/admin/category_view.dart';
import 'package:sahami_app/views/screens/manage/customer/customer_detail_view.dart';
import 'package:sahami_app/views/screens/manage/product/product_create_view.dart';
import 'package:sahami_app/views/screens/splash_view.dart';
import '../utils/constants.dart';
import '../views/screens/home/admin/customer_view.dart';
import '../views/screens/home/admin/main_admin_view.dart';
import '../views/screens/home/admin/setting_admin_view.dart';
import '../views/screens/home/admin/statistics_view.dart';
import '../views/screens/home/home_view.dart';
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
  static const String MAIN_ADMIN_ROUTE = "/MAIN_ADMIN_ROUTE";
  static const String STATISTICS_VIEW_ROUTE = "/STATISTICS_VIEW_ROUTE";
  static const String SETTING_VIEW_ROUTE = "/SETTING_VIEW_ROUTE";

  static const String LOGIN_VIEW_ROUTE = "/LOGIN_VIEW_ROUTE";
  static const String REGISTER_VIEW_ROUTE = "/REGISTER_VIEW_ROUTE";

  static const String CUSTOMER_VIEW_ROUTE = "/CUSTOMER_VIEW_ROUTE";
  static const String CUSTOMER_CREATE_VIEW_ROUTE = "/CUSTOMER_CREATE_VIEW_ROUTE";
  static const String CUSTOMER_DETAIL_VIEW_ROUTE = "/CUSTOMER_DETAIL_VIEW_ROUTE";
  static const String PRODUCT_CREATE_VIEW_ROUTE = "/PRODUCT_CREATE_VIEW_ROUTE";
  static const String CATEGORY_VIEW_ROUTE = "/CATEGORY_VIEW_ROUTE";



  String initialRoute() => SPLASH_PROGRESS_ROUTE;

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch(settings.name) {
      case SPLASH_PROGRESS_ROUTE:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case LOGIN_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case REGISTER_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case MAIN_ADMIN_ROUTE:
        return MaterialPageRoute(builder: (_) => const MainAdminView());
      case STATISTICS_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const StatisticsView());
      case CUSTOMER_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CustomerView());
      case CUSTOMER_CREATE_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CustomerCreateView());
      case CUSTOMER_DETAIL_VIEW_ROUTE:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CustomerDetailView(
              userEntity: args[Constants.ENTITY],
            )
        );
      case PRODUCT_CREATE_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const ProductCreateView());
      case SETTING_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const SettingAdminView());
      case CATEGORY_VIEW_ROUTE:
        return MaterialPageRoute(builder: (_) => const CategoryView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }

  void navigationToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, HOME_ROUTE);
  }
  void navigationToMainAdminScreen(BuildContext context) {
    Navigator.pushNamed(context, MAIN_ADMIN_ROUTE);
  }
  void navigationToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LOGIN_VIEW_ROUTE);
  }
  void navigationToRegisterScreen(BuildContext context) {
    Navigator.pushNamed(context, REGISTER_VIEW_ROUTE);
  }

  void navigationToCustomerScreen(BuildContext context) {
    Navigator.pushNamed(context, CUSTOMER_VIEW_ROUTE);
  }
  void navigationToCustomerCreateScreen(BuildContext context) async {
    Navigator.pushNamed(context, CUSTOMER_CREATE_VIEW_ROUTE);
  }
  void navigationToCustomerDetailScreen(
      BuildContext context, {
      Object? arguments,
  }) {
    Navigator.pushNamed(context, CUSTOMER_DETAIL_VIEW_ROUTE, arguments: arguments);
  }

  void navigationToProductCreateScreen(BuildContext context) {
    Navigator.pushNamed(context, PRODUCT_CREATE_VIEW_ROUTE);
  }

  void navigationToSettingAdminScreen(BuildContext context) {
    Navigator.pushNamed(context, SETTING_VIEW_ROUTE);
  }

  void navigationToCategoryScreen(BuildContext context) {
    Navigator.pushNamed(context, CATEGORY_VIEW_ROUTE);
  }
}