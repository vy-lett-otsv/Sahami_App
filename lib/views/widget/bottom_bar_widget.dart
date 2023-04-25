import 'package:flutter/material.dart';
import '../../enums/enum.dart';
import '../assets/asset_icons.dart';
class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  static const Map<BottomBarItem, String> tabName = {
    BottomBarItem.homeView: 'Dashboard',
    BottomBarItem.orderView: 'Order',
    BottomBarItem.profileView: 'Profile',
    BottomBarItem.customerView: 'Customer',
    BottomBarItem.productView: 'Product',
    BottomBarItem.statisticsView: 'Statistic'
  };

  static const Map<BottomBarItem, Widget> tabIcon = {
    BottomBarItem.homeView: Icon(Icons.home),
    BottomBarItem.orderView: Icon(Icons.article),
    BottomBarItem.profileView: Icon(Icons.person),
    BottomBarItem.customerView: Icon(Icons.person),
    BottomBarItem.productView: ImageIcon(AssetImage(AssetIcons.iconProduct)),
    BottomBarItem.statisticsView: Icon(Icons.home)
  };

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
