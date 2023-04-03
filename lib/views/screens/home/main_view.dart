import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/home/statistics_view.dart';

import '../../constants/ui_color.dart';
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  List pages=[
    StatisticsView(),
    Container(child: Center(child: Text("Customer"))),
    Container(child: Center(child: Text("Product"))),
    Container(child: Center(child: Text("Order"))),
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
        currentIndex: _selectedIndex, //để pick vào nó đổi màu
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: "Home",
          ),
        ],
      ),
    );
  }
}
