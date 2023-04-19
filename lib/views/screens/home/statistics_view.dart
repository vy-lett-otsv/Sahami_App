import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/fake_data.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_statistics.dart';
import 'package:sahami_app/views/widget/ui_card_statistics.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../widget/indicator.dart';
import '../../widget/ui_header_chart.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  int touchedIndex = -1;
  String dropdownValueOrder = FakeData().listOrder.first;
  String dropdownValueRevenue = FakeData().listRevenue.first;

  List<RevenueData> _chartMonthData = [];
  List<RevenueData> _chartYearData = [];

  late TooltipBehavior _tooltipBehavior;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    _chartMonthData = FakeData().getMonthRevenueData();
    _chartYearData = FakeData().getYearRevenueData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(_authService),
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
                  _buildPieChart(),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  _buildLineChart()
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildHeader(AuthService authService) {
    return Container(
      color: UIColors.primarySecond,
      padding: EdgeInsets.only(
          top: DimensManager.dimens.setHeight(50),
          left: DimensManager.dimens.setWidth(20),
          right: DimensManager.dimens.setWidth(20),
          bottom: DimensManager.dimens.setHeight(10)),
      height: DimensManager.dimens.setHeight(140),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                NavigationServices.instance.navigationToSettingAdminScreen(context);
              },
              child: authService.avaAdmin.isEmpty
                  ? const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/564x/2c/bb/0e/2cbb0ee6c1c55b1041642128c902dadd.jpg"),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          authService.avaAdmin),
                    )),
          SizedBox(width: DimensManager.dimens.setWidth(10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIText(authService.userName,
                  color: UIColors.white, fontWeight: FontWeight.bold, size: 20),
              const SizedBox(height: 5),
              const UIText("Admin", color: UIColors.white, size: 16)
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
                onTap: () {}),
            UIButtonStatistics(
                icon: Icons.article, title: UIStrings.addOrder, onTap: () {}),
            UIButtonStatistics(
                icon: Icons.person,
                title: UIStrings.addCustomer,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
            UIButtonStatistics(
                icon: Icons.category,
                title: UIStrings.addCategory,
                onTap: () {})
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
        children: const [
          UICardStatistics(title: UIStrings.totalProduct, data: "10"),
          UICardStatistics(title: UIStrings.totalRevenue, data: "10.000K"),
          UICardStatistics(title: UIStrings.totalCustomer, data: "50"),
          UICardStatistics(title: UIStrings.totalOrder, data: "10.000"),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
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
              dropdownValue: dropdownValueOrder,
              onChange: (String? value) {
                setState(() {
                  dropdownValueOrder = value!;
                });
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
                        sections: FakeData().getSections(touchedIndex),
                        sectionsSpace: 0)),
                  ),
                  SizedBox(width: DimensManager.dimens.setHeight(15)),
                  const Flexible(
                    flex: 1,
                    child: Indicator(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
        margin: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensManager.dimens.setRadius(20)),
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
        ));
  }
}
