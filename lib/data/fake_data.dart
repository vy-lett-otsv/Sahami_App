import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/ui_color.dart';

class FakeData {
  List<String> listOrder = <String>['Hôm nay', 'Tuần', 'Tháng', 'Năm'];
  List<String> listRevenue = <String>['Tháng', 'Năm'];
  
  // static List<OrderData> dataPieChart = [
  //   OrderData(name: "Pending order", percent: 25, color: UIColors.lightRed),
  //   OrderData(name: "Pending payment", percent: 12, color: UIColors.star),
  //   OrderData(name: "Confirm", percent: 63, color: UIColors.primary),
  // ];

  List<RevenueData> getMonthRevenueData() {
    final List<RevenueData> chartData = [
      RevenueData(time: 1, revenue: 10),
      RevenueData(time: 2, revenue: 20),
      RevenueData(time: 3, revenue: 30),
      RevenueData(time: 4, revenue: 1),
      RevenueData(time: 5, revenue: 16),
      RevenueData(time: 6, revenue: 18),
      RevenueData(time: 7, revenue: 18),
      RevenueData(time: 8, revenue: 30),
      RevenueData(time: 9, revenue: 50),
      RevenueData(time: 10, revenue: 60),
      RevenueData(time: 11, revenue: 10),
      RevenueData(time: 12, revenue: 10)
    ];
    return chartData;
  }

  List<RevenueData> getYearRevenueData() {
    final List<RevenueData> chartData = [
      RevenueData(time: 2020, revenue: 17),
      RevenueData(time: 2021, revenue: 20),
      RevenueData(time: 2022, revenue: 30),
      RevenueData(time: 2023, revenue: 10),
    ];
    return chartData;
  }
}

class OrderData {
  final String name;
  final double percent;
  final Color color;

  OrderData({required this.name, required this.percent, required this.color});

  @override
  String toString() {
    return 'OrderData{name: $name, orderAmount: $percent}';
  }
}

class RevenueData {
  final double time;
  final double revenue;

  RevenueData({required this.time, required this.revenue});
}