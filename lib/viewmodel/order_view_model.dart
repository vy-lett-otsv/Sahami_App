import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import '../enums/enum.dart';
import '../views/constants/ui_strings.dart';

class OrderViewModel extends ChangeNotifier {
  int _currentProductTab = 0;

  String idUser = AuthService().userEntity.userId;

  List<OrderEntity> _orderList = [];
  List<OrderEntity> get orderList => _orderList;

  List<OrderEntity> _orderPendingList = [];
  List<OrderEntity> get orderPendingList => _orderPendingList;

  List<OrderEntity> _confirmList = [];
  List<OrderEntity> get confirmList => _confirmList;

  List<OrderEntity> _pendingDelivery = [];
  List<OrderEntity> get pendingDelivery => _pendingDelivery;

  List<OrderEntity> _orderListFinish = [];
  List<OrderEntity> get orderListFinish => _orderListFinish;

  String id = "";

  final docOrder = FirebaseFirestore.instance.collection('order');

  String _date = TimeOption.day.name;
  String get date => _date;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  int selectedIndex = 0;

  PageController _pageController = PageController();
  PageController get pageController => PageController();

  void updateSelected(int index) {
    selectedIndex = index;
    // if(_pageController.hasClients) {
    //   _pageController.jumpToPage(index);
    // }
    // print('Page ${pageController.toString()}');
    notifyListeners();
  }

  Future<void> page(int index) async {

    notifyListeners();
  }

  void changeStaffTab(productTab) {
    _currentProductTab = productTab;
  }
  
  Future<void> updateStatusOrder(String status, String id) async {
    FirebaseFirestore.instance.collection('order').doc(id).update({'orderStatus' : status});
    notifyListeners();
  }

  Future<void> fetchOrderStatus() async {
    _orderPendingList = await fetchOrderStatusOption(UIStrings.pending);
    _confirmList = await fetchOrderStatusOption(UIStrings.confirmed);
    _pendingDelivery = await fetchOrderStatusOption(UIStrings.delivery);
    notifyListeners();
  }

  Future<List<OrderEntity> > fetchOrderStatusOption(String status) async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('orderStatus', isEqualTo: status)
        .get();
    return orderSnapshot.docs.map<OrderEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return OrderEntity.fromJson(data);
    }).toList();
  }

  void changeTab(productTab) {
    _currentProductTab = productTab;
    notifyListeners();
  }

  void updateChangeTab(TabController tabController) {
    changeTab(tabController.index);
    fetchOrder();
    notifyListeners();
  }

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
    await fetchOrder();
    notifyListeners();
  }

  void formatDate() {
    final start = DateFormat('dd/MM/yyy').format(dateRange.start);
    final end = DateFormat('dd/MM/yyy').format(dateRange.end);
    if(start == end && start == DateFormat('dd/MM/yyy').format(DateTime.now())) {
      _date = "Hôm nay";
    } else if(start == end){
      _date = start;
    } else {
      _date = '$start - $end';
    }
    notifyListeners();
  }

  Future<void> listOrderByDay() async {
    DateTime startOfDay = DateTime(dateRange.start.year, dateRange.start.month, dateRange.start.day, 0, 0, 0);
    DateTime endOfDay = DateTime(dateRange.end.year, dateRange.end.month, dateRange.end.day, 23, 59, 59);
    final orderSnapshot = await docOrder
        .where("userEntity.id", isEqualTo: idUser)
        .where("orderStatus", isEqualTo: UIStrings.finish)
        .where("createAt", isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where("createAt", isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .get();
    _orderListFinish = getOrderListFromSnapshot(orderSnapshot);
    print(_orderListFinish.toString());
    notifyListeners();
  }

  Future<void> fetchOrder() async {
    _viewState = ViewState.busy;
    final orderSnapshot = await docOrder
        .where("userEntity.id", isEqualTo: idUser)
        .where("orderStatus", isNotEqualTo: UIStrings.finish)
        .get();
    _orderList = getOrderListFromSnapshot(orderSnapshot);
    listOrderByDay();
    formatDate();
    notifyListeners();
    _viewState = ViewState.success;
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