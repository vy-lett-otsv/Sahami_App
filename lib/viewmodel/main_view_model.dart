import 'package:sahami_app/enums/bottom_bar_item.dart';
import 'package:sahami_app/viewmodel/base_view_model.dart';

class MainViewModel extends BaseViewModel{
  BottomBarItem _currentTab = BottomBarItem.statisticsView;
  BottomBarItem get currentTab => _currentTab;

  void updateCurrentTab(BottomBarItem tab) {
    if(_currentTab == tab) return;
    _currentTab = tab;
  }
}