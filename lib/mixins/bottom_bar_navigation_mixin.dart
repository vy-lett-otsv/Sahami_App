mixin BottomBarNavigationMixin {
  void openHomeView();
  void openOrderView();
  void openProfileView();
  void openCustomerView();
  void openProductView();
  void openStatisticsView();
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

  void openHomeView() {
    _bottomBarNavigationMixin.openHomeView();
  }

  void openOrderView() {
    _bottomBarNavigationMixin.openOrderView();
  }

  void openProfileView() {
    _bottomBarNavigationMixin.openProfileView();
  }

  void openCustomerView() {
    _bottomBarNavigationMixin.openCustomerView();
  }

  void openProductView() {
    _bottomBarNavigationMixin.openProductView();
  }

  void openStatisticsView() {
    _bottomBarNavigationMixin.openProductView();
  }
}