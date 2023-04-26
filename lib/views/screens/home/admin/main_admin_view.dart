import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/mixins/bottom_bar_navigation_mixin.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import 'package:sahami_app/views/screens/home/admin/customer_view.dart';
import 'package:sahami_app/views/screens/home/admin/order_view.dart';
import 'package:sahami_app/views/screens/home/admin/product_view.dart';
import 'package:sahami_app/views/screens/home/admin/statistics_view.dart';
import '../../../../enums/enum.dart';
import '../../../widget/bottom_bar_widget.dart';
import '../home_view.dart';

class MainAdminView extends StatefulWidget {
  const MainAdminView({Key? key}) : super(key: key);

  @override
  State<MainAdminView> createState() => _MainAdminViewState();
}

class _MainAdminViewState extends State<MainAdminView> with BottomBarNavigationMixin{
  final MainViewModel _mainViewModel = MainViewModel();
  Widget? _cacheHomeView;
  Widget? _cacheOrderView;
  Widget? _cacheProfileView;
  Widget? _cacheCustomerView;
  Widget? _cacheProductView;
  Widget? _cacheStatisticsView;

  @override
  void initState() {
    _mainViewModel.screenStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _mainViewModel)],
      child: Scaffold(
        body: Selector<MainViewModel, BottomBarItem>(
          selector: (_, viewModel )=> viewModel.currentTab,
          builder: (_, currentTab, __) {
            return Stack(
              children: [
                _buildTabWithCache(
                  tab: BottomBarItem.homeView,
                  currentTab: currentTab,
                  cache: _cacheHomeView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.orderView,
                  currentTab: currentTab,
                  cache: _cacheOrderView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.profileView,
                  currentTab: currentTab,
                  cache: _cacheProfileView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.customerView,
                  currentTab: currentTab,
                  cache: _cacheCustomerView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.productView,
                  currentTab: currentTab,
                  cache: _cacheProductView,
                ),
                _buildTabWithCache(
                  tab: BottomBarItem.statisticsView,
                  currentTab: currentTab,
                  cache: _cacheStatisticsView,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Selector<MainViewModel, BottomBarItem>(
          selector: (_, viewModel )=> viewModel.currentTab,
          builder: (_, currentTab, __) {
            return BottomBarWidget(
              currentTab: currentTab,
              onItemSelect: _onItemBottomNavigationSelect,
            );
          },
        )
      ),
    );
  }

  Widget _buildTabWithCache({
    required BottomBarItem tab,
    required BottomBarItem currentTab,
    Widget? cache,
  }) {
    print("Hi ${tab}");
    switch (tab) {
      case BottomBarItem.statisticsView:
        return Offstage(
          offstage: currentTab != BottomBarItem.statisticsView,
          child: cache ??
              ((currentTab != BottomBarItem.statisticsView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.statisticsView)),
        );
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
      case BottomBarItem.profileView:
        return Offstage(
          offstage: currentTab != BottomBarItem.profileView,
          child: cache ??
              ((currentTab != BottomBarItem.profileView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.profileView)),
        );
      case BottomBarItem.homeView:
      default:
        return Offstage(
          offstage: currentTab != BottomBarItem.homeView,
          child: cache ??
              ((currentTab != BottomBarItem.homeView)
                  ? Container()
                  : _buildBottomTab(tab: BottomBarItem.homeView)),
        );
    }
  }

  Widget _buildBottomTab({required BottomBarItem tab}) {
    print("build${tab}");
    switch (tab) {
      case BottomBarItem.statisticsView:
        return _cacheStatisticsView = const StatisticsView();
      case BottomBarItem.customerView:
        return _cacheCustomerView = const CustomerView();
      case BottomBarItem.productView:
        return _cacheProductView = const ProductView();
      case BottomBarItem.orderView:
        return _cacheOrderView = const OrderView();
      case BottomBarItem.profileView:
        return _cacheProfileView = const OrderView();
      default:
        return _cacheStatisticsView = const HomeView();
    }
  }

  void _onItemBottomNavigationSelect(BottomBarItem tabItem) {
    _mainViewModel.updateCurrentTab(tabItem);
  }

  @override
  void openCustomerView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.customerView);
  }

  @override
  void openHomeView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.homeView);
  }

  @override
  void openOrderView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.orderView);
  }

  @override
  void openProductView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.productView);
  }

  @override
  void openProfileView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.profileView);
  }

  @override
  void openStatisticsView() {
    _mainViewModel.updateCurrentTab(BottomBarItem.statisticsView);
  }
}
