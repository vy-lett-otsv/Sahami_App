import 'package:flutter/material.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../enums/enum.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';

class BottomBarWidget extends StatelessWidget {
   BottomBarWidget(
      {Key? key, required this.currentTab, required this.onItemSelect})
      : super(key: key);

  final BottomBarItem currentTab;
  final ValueChanged<BottomBarItem> onItemSelect;
  final MainViewModel _mainViewModel = MainViewModel();

  @override
  Widget build(BuildContext context) {
    if (AuthService().roleUserEntity == "admin") {
      return BottomNavigationBar(
        elevation: 4,
        items: _mainViewModel.bottomBarItemAdmin.map((e) => _buildItem(e)).toList(),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: UIColors.white,
        onTap: (index) {
          if (currentTab.index != index) {
            onItemSelect(_mainViewModel.bottomBarItemAdmin[index]);
          }
        },
      );
    }
    return BottomNavigationBar(
      elevation: 4,
      currentIndex: 0,
      items: _mainViewModel.bottomBarItemUser.map((e) => _buildItem(e)).toList(),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: UIColors.white,
      onTap: (index) {
        if (currentTab.index != index) {
          onItemSelect(_mainViewModel.bottomBarItemUser[index]);
        }
      },
    );
  }

  BottomNavigationBarItem _buildItem(BottomBarItem tabItem) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Image.asset(
            _mainViewModel.tabIcon[tabItem]!,
            fit: BoxFit.contain,
            color: (currentTab == tabItem)
                ? UIColors.primary
                : UIColors.background,
            height: DimensManager.dimens.setHeight(13),
            width: DimensManager.dimens.setWidth(13),
          ),
          SizedBox(height: DimensManager.dimens.setHeight(2)),
          UIText(
            (_mainViewModel.tabName[tabItem]!),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: DimensManager.dimens.setSp(13),
              color: (currentTab == tabItem)
                  ? UIColors.primary
                  : UIColors.background,
            ),
          ),
        ],
      ),
      label: _mainViewModel.tabName[tabItem],
    );
  }
}
