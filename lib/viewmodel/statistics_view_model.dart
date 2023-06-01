import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:intl/intl.dart' as intl;
import '../data/fake_data.dart';
import '../services/auth_service.dart';
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

  String dropdownValueOrder = FakeData().listOrder.first;



  Future<void> updateDropDownPieChart(String value) async {
    dropdownValueOrder = value;
    await pieChartList(value);
    print(dropdownValueOrder);
    notifyListeners();
  }

  Future<List<OrderEntity>> fetchDataOrderListToday() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('createAt', isEqualTo: DateFormat.yMMMMd().format(DateTime.now()))
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOrderListWeek() async {
    final now = DateTime.now();
    final startOfWeek = DateFormat.yMMMMd().format(now.subtract(Duration(days: now.weekday - 1)));
    final endOfWeek = DateFormat.yMMMMd().format(now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 7)));
    print("start $startOfWeek");
    print(endOfWeek);
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('createAt', isLessThanOrEqualTo: startOfWeek, isGreaterThanOrEqualTo: endOfWeek)
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOrderMonth() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('createAtMonth', isEqualTo: '${DateTime.now().month}')
        .where('createAtYear', isEqualTo: '${DateTime.now().year}')
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOrderYear() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('createAtYear', isEqualTo: '${DateTime.now().year}')
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOptionToday(String option) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: option)
        .where('createAt', isEqualTo: DateFormat.yMMMMd().format(DateTime.now()))
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOptionWeek(String option) async {
    final now = DateTime.now();
    final startOfWeek = DateFormat.yMMMMd().format(now.subtract(Duration(days: now.weekday - 1)));
    final endOfWeek = DateFormat.yMMMMd().format(now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 7)));
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: option)
        .where('createAt', isLessThanOrEqualTo: startOfWeek, isGreaterThanOrEqualTo: endOfWeek)
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOptionMonth(String option) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: option)
        .where('createAtMonth', isEqualTo: '${DateTime.now().month}')
        .where('createAtYear', isEqualTo: '${DateTime.now().year}')
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  Future<List<OrderEntity>> fetchDataOptionYear(String option) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: option)
        .where('createAtYear', isEqualTo: '${DateTime.now().year}')
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  // Future<List<OrderEntity>> emptyPieChart() async {
  //   final collectionRef = await FirebaseFirestore.instance.collection('order').where("userEntity.id", isEqualTo: AuthService().userEntity.userId).get();
  //   return collectionRef.docs.map<OrderEntity>((docSnapshot) {
  //     final data = docSnapshot.data();
  //     return OrderEntity.fromJson(data);
  //   }).toList();
  // }

  Future<void> pieChartList(String dropdownValueOrder) async {
    switch(dropdownValueOrder) {
      case "Tuần": {
        _pendingOrderList = await fetchDataOptionWeek(UIStrings.pending);
        _confirmedOrderList = await fetchDataOptionWeek(UIStrings.confirmed);
        _pendingDeliveryList = await fetchDataOptionWeek(UIStrings.delivery);
        _cancelOrderList = await fetchDataOptionWeek(UIStrings.cancelOrder);
        _finishOrderList = await fetchDataOptionWeek(UIStrings.finish);
        final orderList = await fetchDataOrderListWeek();
        addDataPieChart(orderList);
      }
      break;
      case "Tháng": {
          _pendingOrderList = await fetchDataOptionMonth(UIStrings.pending);
          _confirmedOrderList = await fetchDataOptionMonth(UIStrings.confirmed);
          _pendingDeliveryList = await fetchDataOptionMonth(UIStrings.delivery);
          _cancelOrderList = await fetchDataOptionMonth(UIStrings.cancelOrder);
          _finishOrderList = await fetchDataOptionMonth(UIStrings.finish);
          final orderList = await fetchDataOrderMonth();
          addDataPieChart(orderList);
      }
      break;
      case "Năm": {
        _pendingOrderList = await fetchDataOptionYear(UIStrings.pending);
        _confirmedOrderList = await fetchDataOptionYear(UIStrings.confirmed);
        _pendingDeliveryList = await fetchDataOptionYear(UIStrings.delivery);
        _cancelOrderList = await fetchDataOptionYear(UIStrings.cancelOrder);
        _finishOrderList = await fetchDataOptionYear(UIStrings.finish);
        final orderList = await fetchDataOrderYear();
        addDataPieChart(orderList);
      }
      break;
      default: {
        _pendingOrderList = await fetchDataOptionToday(UIStrings.pending);
        _confirmedOrderList = await fetchDataOptionToday(UIStrings.confirmed);
        _pendingDeliveryList = await fetchDataOptionToday(UIStrings.delivery);
        _cancelOrderList = await fetchDataOptionToday(UIStrings.cancelOrder);
        _finishOrderList = await fetchDataOptionToday(UIStrings.finish);
        final orderList = await fetchDataOrderListToday();
        addDataPieChart(orderList);
      }
      break;
    }
    notifyListeners();
  }

  void addDataPieChart(List<OrderEntity> orderList) {
    dataPieChart = [];
    double pendingOrder = (pendingOrderList.length / orderList.length * 100).roundToDouble();
    double confirm = (confirmedOrderList.length / orderList.length * 100).roundToDouble();
    double pendingDelivery = (pendingDeliveryList.length / orderList.length * 100).roundToDouble();
    double finish = (finishOrderList.length / orderList.length * 100).roundToDouble();
    double cancel = (cancelOrderList.length / orderList.length * 100).roundToDouble();

    if(pendingOrder.isNaN && pendingDelivery.isNaN && finish.isNaN && cancel.isNaN) {
      dataPieChart = [];
    } else {
      dataPieChart.add(OrderData(name: UIStrings.pending, percent: pendingOrder, color: UIColors.star));
      dataPieChart.add(OrderData(name: UIStrings.confirmed, percent: confirm, color: UIColors.orange));
      dataPieChart.add(OrderData(name: UIStrings.delivery, percent: pendingDelivery, color: UIColors.delivery));
      dataPieChart.add(OrderData(name: UIStrings.finish, percent: finish, color: UIColors.primary));
      dataPieChart.add(OrderData(name: UIStrings.cancelOrder, percent: cancel, color: UIColors.lightRed));
    }
    print(dataPieChart.toString());
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
    // pieChartList();
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
