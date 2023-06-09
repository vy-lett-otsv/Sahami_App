import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/home/home_view.dart';
import 'package:sahami_app/views/screens/home/user/my_order_view.dart';
import '../data/remote/entity/user_entity.dart';
import '../services/auth_service.dart';
import '../views/screens/home/admin/customer_view.dart';
import '../views/screens/home/admin/order_view.dart';
import '../views/screens/home/admin/product_view.dart';
import '../views/screens/home/admin/statistics_view.dart';
import '../views/screens/home/user/profile_view.dart';

class MainViewModel extends ChangeNotifier{
  List _pages = [];

  List get pages => _pages;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;


  Animation<double>? animation;
  AnimationController? controller;

  checkIfLogin(bool mounted, BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        AuthService().isLogin = true;
        AuthService().roleUser(context, user.uid);
        notifyListeners();
      }
      print(AuthService().isLogin);
    });
  }

  Future<void> awaitLogin (bool mounted, BuildContext context) async {
    await checkIfLogin(mounted, context);
  }


  void bottomBarItem() {
    if (AuthService().userEntity.role == "admin") {
      _pages = const [
        StatisticsView(),
        CustomerView(),
        ProductView(),
        OrderView(),
      ];
    } else {
      _pages = const [
        HomeView(),
        MyOrderView(),
        ProfileView(),
      ];
    }
  }

  void onTapNav(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
  }
}
