import 'package:flutter/material.dart';

import '../../enums/bottom_bar_item.dart';

class BottomBarWidget extends StatelessWidget {
  final BottomBarItem currentTab;

  final ValueChanged<BottomBarItem> onItemSelect;

  const BottomBarWidget({
    Key? key,
    required this.currentTab,
    required this.onItemSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
