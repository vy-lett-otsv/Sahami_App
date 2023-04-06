import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/screens/home/order_view.dart';
import 'package:sahami_app/views/screens/home/product_view.dart';
import 'package:sahami_app/views/screens/home/statistics_view.dart';
import '../../../enums/bottom_bar_item.dart';
import '../../../mixins/bottom_bar_navigation_mixin.dart';
import '../../../viewmodel/main_view_model.dart';
import '../../constants/ui_color.dart';
import '../../widget/bottom_bar_widget.dart';
import 'customer_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with BottomBarNavigationMixin {
  late MainViewModel _mainViewModel;
  Widget? _cacheStatisticView;
  Widget? _cacheCustomerView;
  Widget? _cacheOrderView;
  Widget? _cacheProductView;

  @override
  void initState() {
    super.initState();
    _initViewModel(context);
    BottomBarNavigationModel.instance.registerMixin(this);
  }

  void _initViewModel(BuildContext context) {
    _mainViewModel = MainViewModel()..onInitView(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _mainViewModel,
      child: Scaffold(
        backgroundColor: UIColors.primary,
        body: Selector<MainViewModel, BottomBarItem>(
          selector: (_, viewModel) => viewModel.currentTab,
          builder: (_, currentTab, __) {
            return Stack(
              children: [
                _buildTabWithCache(
                  tab: BottomBarItem.statisticsView,
                  currentTab: currentTab,
                  cache: _cacheStatisticView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.customerView,
                  currentTab: currentTab,
                  cache: _cacheCustomerView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.productView,
                  currentTab: currentTab,
                  cache: _cacheCustomerView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.orderView,
                  currentTab: currentTab,
                  cache: _cacheOrderView,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Selector<MainViewModel, BottomBarItem>(
          selector: (_, viewModel) => viewModel.currentTab,
          builder: (_, currentTab, __) {
            return BottomBarWidget(
              currentTab: currentTab,
              onItemSelect: _onItemBottomNavigationSelect,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabWithCache({
    required BottomBarItem tab,
    required BottomBarItem currentTab,
    Widget? cache,
  }) {
    switch (tab) {
      case BottomBarItem.customerView:
        return Offstage(
          offstage: currentTab != BottomBarItem.customerView,
          child: cache ??
              ((currentTab != BottomBarItem.customerView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.customerView)),
        );
      case BottomBarItem.productView:
        return Offstage(
          offstage: currentTab != BottomBarItem.productView,
          child: cache ??
              ((currentTab != BottomBarItem.productView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.productView)),
        );
      case BottomBarItem.orderView:
        return Offstage(
          offstage: currentTab != BottomBarItem.orderView,
          child: cache ??
              ((currentTab != BottomBarItem.orderView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.orderView)),
        );
      case BottomBarItem.statisticsView:
      default:
        return Offstage(
          offstage: currentTab != BottomBarItem.statisticsView,
          child: cache ??
              ((currentTab != BottomBarItem.statisticsView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.statisticsView)),
        );
    }
  }

  Widget _buildBottomTab({required BottomBarItem tab}) {
    switch (tab) {
      case BottomBarItem.customerView:
        return _cacheCustomerView = CustomerView();
      case BottomBarItem.productView:
        return _cacheProductView = ProductView();
      case BottomBarItem.orderView:
        return _cacheOrderView = OrderView();
      case BottomBarItem.statisticsView:
      default:
        return _cacheStatisticView = StatisticsView();
    }
  }

  void _onItemBottomNavigationSelect(BottomBarItem tabItem) {
    _mainViewModel.updateCurrentTab(tabItem);
  }

 @override
 void openStatisticsView() {
   _mainViewModel.updateCurrentTab(BottomBarItem.statisticsView);
 }

  @override
  void openCustomerView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.customerView);
  }

  @override
  void openProductView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.productView);
  }

  @override
  void openOrderView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.orderView);
  }

}

