import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/fake_data.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/viewmodel/customer_view_model.dart';
import 'package:sahami_app/viewmodel/product_view_model.dart';
import 'package:sahami_app/viewmodel/statistics_view_model.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_statistics.dart';
import 'package:sahami_app/views/widget/ui_card_statistics.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../widget/ui_header_chart.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  int touchedIndex = -1;
  String dropdownValueRevenue = FakeData().listRevenue.first;

  List<RevenueData> _chartMonthData = [];
  List<RevenueData> _chartYearData = [];

  late TooltipBehavior _tooltipBehavior;

  final ProductViewModel _productViewModel = ProductViewModel();
  final CustomerViewModel _customerViewModel = CustomerViewModel();
  final StatisticsViewModel _statisticsViewModel = StatisticsViewModel();

  @override
  void initState() {
    _chartMonthData = FakeData().getMonthRevenueData();
    _chartYearData = FakeData().getYearRevenueData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _productViewModel.fetchProducts("product");
    _customerViewModel.fetchCustomer();
    _statisticsViewModel.fetch();
    _statisticsViewModel.pieChartList(FakeData().listOrder.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _productViewModel),
        ChangeNotifierProvider(create: (_) => _customerViewModel),
        ChangeNotifierProvider(create: (_) => _statisticsViewModel)
      ],
      child: Scaffold(
        backgroundColor: UIColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  _buildCreateButton(),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  _buildStatistics(),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  Consumer<StatisticsViewModel>(builder: (_, viewModel, __) {
                    return _buildPieChart(viewModel);
                  }),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  _buildLineChart()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: UIColors.primarySecond,
      padding: EdgeInsets.only(
          top: DimensManager.dimens.setHeight(70),
          left: DimensManager.dimens.setWidth(20),
          right: DimensManager.dimens.setWidth(20),
          bottom: DimensManager.dimens.setHeight(10)),
      height: DimensManager.dimens.setHeight(150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                NavigationServices.instance
                    .navigationToSettingAdminScreen(context);
              },
              child: CircleAvatar(
                      radius: 30,
                      backgroundColor: null,
                      backgroundImage: NetworkImage(AuthService().userEntity.image),
                    )),
          SizedBox(width: DimensManager.dimens.setWidth(10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIText(AuthService().userEntity.userName,
                  color: UIColors.white, fontWeight: FontWeight.bold, size: 20),
              const SizedBox(height: 5),
              const UIText(UIStrings.admin, color: UIColors.white, size: 16)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10)),
      child: Padding(
        padding: EdgeInsets.all(DimensManager.dimens.setWidth(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UIButtonStatistics(
                title: UIStrings.addProduct,
                image: AssetIcons.iconProductWhite,
                onTap: () {
                  NavigationServices.instance.navigationToProductCreateScreen(context);
                }),
            UIButtonStatistics(
                icon: Icons.article, title: UIStrings.addOrder, onTap: () {}),
            UIButtonStatistics(
                icon: Icons.person,
                title: UIStrings.addCustomer,
                onTap: () {
                  NavigationServices.instance.navigationToCustomerCreateScreen(context);
                }),
            UIButtonStatistics(
              icon: Icons.category,
              title: UIStrings.addCategory,
              onTap: () {
                NavigationServices.instance.navigationToCategoryScreen(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10)),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 1.9,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Consumer<ProductViewModel>(builder: (_, productViewModel, __) {
            return UICardStatistics(
                title: UIStrings.totalProduct,
                data: "${productViewModel.productList.length}");
          }),
          Consumer<StatisticsViewModel>(builder: (_, statisticsViewModel, __) {
            return UICardStatistics(
                title: UIStrings.totalOrder, data: "${statisticsViewModel.orderList.length}");
          }),
          Consumer<CustomerViewModel>(
            builder: (_, customerViewModel, __) {
              return UICardStatistics(
                  title: UIStrings.totalCustomer,
                  data: "${customerViewModel.userList.length}");
            },
          ),
          Consumer<StatisticsViewModel>(builder: (_, statisticsViewModel, __) {
            return UICardStatistics(
                title: UIStrings.totalRevenue, data: statisticsViewModel.formatRevenue);
          }),
        ],
      ),
    );
  }

  Widget _buildPieChart(StatisticsViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
        color: UIColors.white,
      ),
      height: DimensManager.dimens.setHeight(250),
      child: Container(
        padding: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticsHeaderWidget(
              title: UIStrings.order,
              dropdownValue: viewModel.dropdownValueOrder,
              onChange: (String? value) {
                viewModel.updateDropDownPieChart(value!);
              },
              list: FakeData().listOrder,
            ),
            SizedBox(height: DimensManager.dimens.setHeight(10)),
            Flexible(
              flex: 6,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: PieChart(PieChartData(
                        sections: viewModel.getSections(touchedIndex),
                        sectionsSpace: 0)),
                  ),
                  SizedBox(width: DimensManager.dimens.setHeight(15)),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: viewModel.dataPieChart.map((data) => Container(
                        child: _buildIndicatorItem(
                          color: data.color,
                          text: data.name,
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildIndicator() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: _statisticsViewModel.dataPieChart.map((data) => Container(
  //       child: _buildIndicatorItem(
  //         color: data.color,
  //         text: data.name,
  //       ),
  //     )).toList(),
  //   );
  // }

  Widget _buildIndicatorItem({
    required Color color,
    required String text,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(5)),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(5))
            ),
          ),
          SizedBox(width: DimensManager.dimens.setHeight(10)),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      margin: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
        color: UIColors.white,
      ),
      height: DimensManager.dimens.setHeight(500),
      child: Container(
        padding: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticsHeaderWidget(
              title: UIStrings.revenue,
              dropdownValue: dropdownValueRevenue,
              onChange: (String? value) {
                setState(() {
                  dropdownValueRevenue = value!;
                });
              },
              list: FakeData().listRevenue,
            ),
            SizedBox(height: DimensManager.dimens.setHeight(10)),
            Flexible(
              flex: 10,
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  LineSeries<RevenueData, double>(
                    name: UIStrings.revenue,
                    color: UIColors.primary,
                    dataSource: dropdownValueRevenue == "Month"
                        ? _chartMonthData
                        : _chartYearData,
                    xValueMapper: (RevenueData revenue, _) => revenue.time,
                    yValueMapper: (RevenueData revenue, _) => revenue.revenue,
                  )
                ],
                primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 1,
                ),
                primaryYAxis: NumericAxis(labelFormat: '{value}M'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
