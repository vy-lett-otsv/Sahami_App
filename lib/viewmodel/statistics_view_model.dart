import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';

class StatisticsViewModel extends ChangeNotifier{
  List<OrderEntity> _orderList = [];

  List<OrderEntity> get orderList => _orderList;

  double _totalRevenue = 0;
  double get totalRevenue => _totalRevenue;

  Future<void> fetchStatistics() async {
    final orderSnapshot = await FirebaseFirestore.instance.collection('order').get();
    _orderList = orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
    _totalRevenue = orderList.fold(0, (sum, item) => sum + item.orderAmount);
    notifyListeners();
  }
}

