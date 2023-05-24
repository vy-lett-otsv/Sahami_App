import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/views/constants/ui_color.dart';

import '../data/remote/entity/user_entity.dart';

class OrderViewModel extends ChangeNotifier {
  int _currentProductTab = 0;

  String idUser = AuthService().userEntity.userId;

  List<OrderEntity> _orderList = [];
  List<OrderEntity> get orderList => _orderList;

  List<OrderEntity> _orderListFinish = [];
  List<OrderEntity> get orderListFinish => _orderListFinish;

  String id = "";

  final docOrder = FirebaseFirestore.instance.collection('order');

  String date = "Hôm nay";

  void changeTab(productTab) {
    _currentProductTab = productTab;
  }

  void updateChangeTab(TabController tabController) {
    changeTab(tabController.index);
    fetchOrder();
    notifyListeners();
  }

  void formatDate() {
    final start = dateRange.start;
    final end = dateRange.end;
    if(start == end) {
      date = '${start.day}/${start.month}/${start.year}';
    } else {
      date = '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
    }
    notifyListeners();
  }

  // start == end ? '${start.day}/${start.month}/${start.year}':
  // '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}',

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now()
  );
  
  Future pickDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context, 
        initialDateRange: dateRange,
        firstDate: DateTime(1900), 
        lastDate: DateTime(2100),
      builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: UIColors.primary,
                onPrimary: UIColors.white,
                onSurface: Colors.blueAccent,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: UIColors.white, // button text color
                ),
              ),
            ), child: child!,
          );
      }
    );
    if(newDateRange == null) return;
    dateRange = newDateRange;
    notifyListeners();
  }

  Future<void> listOrderByDay() async {
    final orderSnapshot = await docOrder
        .where("userEntity.id", isEqualTo: idUser)
        .where("orderStatus", isEqualTo: 'Đã hoàn thành')
        // .where("createAt", isLessThanOrEqualTo: dateRange.start.microsecondsSinceEpoch)
        // .where("createAt", isGreaterThanOrEqualTo: dateRange.start.microsecondsSinceEpoch,isLessThanOrEqualTo: dateRange.end.microsecondsSinceEpoch)
        .get();
    _orderListFinish = getOrderListFromSnapshot(orderSnapshot);
    print(_orderListFinish.toString());
    notifyListeners();
  }

  Future<void> fetchOrder() async {
    final orderSnapshot = await docOrder
        .where("userEntity.id", isEqualTo: idUser)
        .where("orderStatus", isNotEqualTo: 'Đã hoàn thành')
        .get();

    _orderList = getOrderListFromSnapshot(orderSnapshot);
    await listOrderByDay();
    notifyListeners();
  }

  List<OrderEntity> getOrderListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return OrderEntity.fromJson(data);
    }).toList();
  }


  Future<void> deleteProduct(BuildContext context, String documentId) async {
    await FirebaseFirestore.instance
        .collection("order")
        .doc(documentId)
        .delete();
    fetchOrder();
  }


}