import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/screens/home/customer_view.dart';
import 'package:sahami_app/views/screens/home/statistics_view.dart';
import 'package:sahami_app/views/screens/home/product_view.dart';
import '../../constants/ui_color.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  List pages=[
    const StatisticsView(),
    const CustomerView(),
    const ProductView(),
    const Center(child: Text("Order")),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: UIColors.primary,
        unselectedItemColor: UIColors.text,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, //để pick vào nó đổi màu
        onTap: onTapNav,
        type: BottomNavigationBarType.fixed,
        items:  const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: UIStrings.statistics,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: UIStrings.customer,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetIcons.iconProduct)),
            activeIcon: ImageIcon(AssetImage(AssetIcons.iconProductPick)),
            label: UIStrings.product,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: UIStrings.order,
          ),
        ],
      ),
    );
  }
}
