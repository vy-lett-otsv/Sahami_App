import 'package:flutter/material.dart';
import 'package:sahami_app/services/auth_service.dart';
import '../enums/enum.dart';
import '../views/assets/asset_icons.dart';

class MainViewModel extends ChangeNotifier {
  BottomBarItem _currentTab = BottomBarItem.homeView;

  BottomBarItem get currentTab => _currentTab;

  Map<BottomBarItem, String> tabName = {
    BottomBarItem.homeView: 'Dashboard',
    BottomBarItem.orderView: 'Order',
    BottomBarItem.profileView: 'Profile',
    BottomBarItem.customerView: 'Customer',
    BottomBarItem.productView: 'Product',
    BottomBarItem.statisticsView: 'Statistic'
  };

  Map<BottomBarItem, String> tabIcon = {
    BottomBarItem.homeView: AssetIcons.iconProduct,
    BottomBarItem.orderView: AssetIcons.iconProduct,
    BottomBarItem.profileView: AssetIcons.iconProduct,
    BottomBarItem.customerView: AssetIcons.iconProduct,
    BottomBarItem.productView: AssetIcons.iconProduct,
    BottomBarItem.statisticsView: AssetIcons.iconProduct
  };

  List<BottomBarItem> bottomBarItemAdmin = [
    BottomBarItem.statisticsView,
    BottomBarItem.customerView,
    BottomBarItem.productView,
    BottomBarItem.orderView,
  ];

  List<BottomBarItem> bottomBarItemUser = [
    BottomBarItem.homeView,
    BottomBarItem.orderView,
    BottomBarItem.profileView,
  ];

  void updateCurrentTab(BottomBarItem tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }

  void screenStart() {
    if (AuthService().roleUserEntity == "admin") {
      _currentTab = BottomBarItem.statisticsView;
    } else {
      _currentTab = BottomBarItem.homeView;
    }
    notifyListeners();
  }

  void navigationProductView() {
    _currentTab =  BottomBarItem.profileView;
  }
}
