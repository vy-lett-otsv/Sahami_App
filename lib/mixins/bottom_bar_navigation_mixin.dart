mixin BottomBarNavigationMixin {
  void openStatisticsView();
  void openCustomerView();
  void openProductView();
  void openOrderView();
}

class BottomBarNavigationModel {
  static BottomBarNavigationModel? _instance;

  static BottomBarNavigationModel get instance => BottomBarNavigationModel();

  BottomBarNavigationModel._();

  factory BottomBarNavigationModel() {
    _instance ??= BottomBarNavigationModel._();
    return _instance!;
  }

  late BottomBarNavigationMixin _bottomBarNavigationMixin;

  registerMixin(BottomBarNavigationMixin mixin) {
    _bottomBarNavigationMixin = mixin;
  }

  void openStatisticsView() {
    _bottomBarNavigationMixin.openStatisticsView();
  }

  void openCustomerView() {
    _bottomBarNavigationMixin.openCustomerView();
  }

  void openProductView() {
    _bottomBarNavigationMixin.openProductView();
  }

  void openOrderView() {
    _bottomBarNavigationMixin.openOrderView();
  }

}