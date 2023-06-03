import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sahami_app/enums/enum.dart';
import '../data/fake_data.dart';
import '../views/constants/ui_color.dart';
import '../views/constants/ui_strings.dart';

class StatisticsViewModel extends ChangeNotifier {
  List<OrderEntity> _orderList = [];

  List<OrderEntity> get orderList => _orderList;

  List<OrderEntity> _revenueList = [];

  List<OrderEntity> get revenueList => _revenueList;

  double _totalRevenue = 0;

  double get totalRevenue => _totalRevenue;

  String formatRevenue = "";

  List<OrderData> dataPieChart = [];

  List<OrderEntity> _pendingOrderList = [];

  List<OrderEntity> get pendingOrderList => _pendingOrderList;

  List<OrderEntity> _pendingDeliveryList = [];

  List<OrderEntity> get pendingDeliveryList => _pendingDeliveryList;

  List<OrderEntity> _confirmedOrderList = [];

  List<OrderEntity> get confirmedOrderList => _confirmedOrderList;

  List<OrderEntity> _cancelOrderList = [];

  List<OrderEntity> get cancelOrderList => _cancelOrderList;

  List<OrderEntity> _finishOrderList = [];

  List<OrderEntity> get finishOrderList => _finishOrderList;

  String dropdownValueOrder = TimeOption.day.nameTime;


  Future<void> updateDropDownPieChart(String value) async {
    dropdownValueOrder = value;
    await pieChartList(value);
    notifyListeners();
  }

  DateTime startOfDay = DateTime.now();
  DateTime endOfDay = DateTime.now();

  void setDate(String time) {
    startOfDay = DateTime.now();
    endOfDay = DateTime.now();
    if(time == TimeOption.day.nameTime) {
      startOfDay = DateTime(startOfDay.year, startOfDay.month, startOfDay.day);
      endOfDay = DateTime(endOfDay.year, endOfDay.month, endOfDay.day, 23, 59, 59);
    } else if(time == TimeOption.week.nameTime) {
      startOfDay = startOfDay.add(Duration(
          days: DateTime.daysPerWeek - DateTime.now().weekday - 7,
          hours: -startOfDay.hour,
          minutes: -startOfDay.minute,
          seconds: -startOfDay.second,
      ));
      endOfDay = endOfDay.add(Duration(
          days: DateTime.now().day - 1,
          hours: 23 - endOfDay.hour,
          minutes: 59 - endOfDay.minute,
          seconds: 59 - endOfDay.second,
      ));
    } else if(time == TimeOption.month.nameTime) {
      startOfDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
      endOfDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59);
    } else {
      startOfDay = DateTime(DateTime.now().year, 1, 1);
      endOfDay = DateTime(DateTime.now().year + 1, 1, 0, 23, 59, 59);
    }
  }

  Future<List<OrderEntity>> fetchDataOrderList(DateTime start, DateTime end) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where("createAt", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where("createAt", isLessThanOrEqualTo: Timestamp.fromDate(end))
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOption(String option, DateTime start, DateTime end) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: option)
        .where("createAt", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where("createAt", isLessThanOrEqualTo: Timestamp.fromDate(end))
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<void> fetchDataDay(String time) async {
    setDate(time);
    _pendingOrderList = await fetchDataOption(UIStrings.pending, startOfDay, endOfDay);
    _confirmedOrderList = await fetchDataOption(UIStrings.confirmed, startOfDay, endOfDay);
    _pendingDeliveryList = await fetchDataOption(UIStrings.delivery, startOfDay, endOfDay);
    _cancelOrderList = await fetchDataOption(UIStrings.cancelOrder, startOfDay, endOfDay);
    _finishOrderList = await fetchDataOption(UIStrings.finish, startOfDay, endOfDay);
  }

  Future<void> pieChartList(String dropdownValueOrder) async {
    if(dropdownValueOrder == TimeOption.day.nameTime) {
      await fetchDataDay(TimeOption.day.nameTime);
    }
    else if(dropdownValueOrder == TimeOption.week.nameTime) {
      await fetchDataDay(TimeOption.week.nameTime);
    } else if(dropdownValueOrder == TimeOption.month.nameTime) {
      fetchDataDay(TimeOption.month.nameTime);
    } else {
      fetchDataDay(TimeOption.year.nameTime);
    }
    final orderList = await fetchDataOrderList(startOfDay, endOfDay);
    addDataPieChart(orderList);

    notifyListeners();
  }

  void addDataPieChart(List<OrderEntity> orderList) {
    dataPieChart = [];
    double pendingOrder = (pendingOrderList.length / orderList.length * 100).roundToDouble();
    double confirm = (confirmedOrderList.length / orderList.length * 100).roundToDouble();
    double pendingDelivery = (pendingDeliveryList.length / orderList.length * 100).roundToDouble();
    double finish = (finishOrderList.length / orderList.length * 100).roundToDouble();
    double cancel = (cancelOrderList.length / orderList.length * 100).roundToDouble();

    dataPieChart.add(OrderData(name: UIStrings.pending, percent: pendingOrder, color: UIColors.star));
    dataPieChart.add(OrderData(name: UIStrings.confirmed, percent: confirm, color: UIColors.orange));
    dataPieChart.add(OrderData(name: UIStrings.delivery, percent: pendingDelivery, color: UIColors.delivery));
    dataPieChart.add(OrderData(name: UIStrings.finish, percent: finish, color: UIColors.primary));
    dataPieChart.add(OrderData(name: UIStrings.cancelOrder, percent: cancel, color: UIColors.lightRed));

    if(pendingOrder.isNaN && confirm.isNaN && pendingDelivery.isNaN && finish.isNaN && cancel.isNaN) {
      dataPieChart = [];
    }
  }

  List<PieChartSectionData> getSections(int touchedIndex) {
    return dataPieChart
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: '${data.percent}%',
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: UIColors.black,
        ),
      );

      return MapEntry(index, value);
    })
        .values
        .toList();
  }

  Future<void> fetchOrder() async {
    final orderSnapshot = await FirebaseFirestore.instance.collection('order')
        .get();
    _orderList = orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
    notifyListeners();
  }

  Future<void> fetchRevenue() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: UIStrings.finish)
        .get();
    _revenueList = orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
    _totalRevenue = revenueList.fold(0, (sum, item) => sum + item.orderAmount);
    formatterRevenue();
    notifyListeners();
  }

  void fetch() {
    fetchOrder();
    fetchRevenue();
  }

  void formatterRevenue() {
    if (_totalRevenue >= 1000000.0) {
      final formatter = intl.NumberFormat.compact(locale: 'vi_VN');
      if (_totalRevenue >= 1000000000.0) {
        formatRevenue = '${formatter.format(_totalRevenue)}ỷ';
      } else {
        formatRevenue = '${formatter.format(_totalRevenue)}iệu';
      }
    } else {
      final formatter = intl.NumberFormat.currency(
          locale: 'vi_VN', decimalDigits: 0, symbol: 'đ');
      formatRevenue = formatter.format(_totalRevenue);
    }
  }
}
