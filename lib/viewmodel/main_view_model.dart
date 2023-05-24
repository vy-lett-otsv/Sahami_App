import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/home/home_view.dart';
import 'package:sahami_app/views/screens/home/user/my_order_view.dart';
import '../services/auth_service.dart';
import '../views/screens/home/admin/customer_view.dart';
import '../views/screens/home/admin/order_view.dart';
import '../views/screens/home/admin/product_view.dart';
import '../views/screens/home/admin/statistics_view.dart';

class MainViewModel extends ChangeNotifier {
  List _pages = [];

  List get pages => _pages;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

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
        OrderView(),
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
