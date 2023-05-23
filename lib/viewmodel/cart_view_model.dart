import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../data/data_local.dart';
import '../data/remote/entity/order_entity.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';

class CartViewModel extends ChangeNotifier{
  Map<dynamic, dynamic> updatedElement = {};

  int totalAmount = 0;

  void calculateTotal() {
    totalAmount = CartService().orderList.fold(0, (previous, current) => previous + current['quantity'] as int);
  }

  void displayTextOptionItem(int index) {
    var selectedElement = CartService().orderList[index];
    updatedElement = Map.from(selectedElement)
      ..remove('image')
      ..remove('price')
      ..remove('priceSale')
      ..remove('name_product')
      ..remove('quantity');
  }

  Map<String, dynamic> getNamedSyrup() => {
    'size': updatedElement['size'],
    if (updatedElement.containsKey('ice')) 'ice': updatedElement['ice'],
    if (updatedElement.containsKey('sugar')) 'sugar': updatedElement['sugar'],
    if (updatedElement.containsKey('brown_sugar_syrup')) 'brown_sugar_syrup': 'Thêm ${updatedElement['brown_sugar_syrup']} pump si rô brown sugar',
    if (updatedElement.containsKey('caramel_syrup')) 'caramelSyrup': 'Thêm ${updatedElement['caramel_syrup']} pump si rô caramel',
    if (updatedElement.containsKey('vanilla_syrup')) 'vanillaSyrup': 'Thêm ${updatedElement['vanilla_syrup']} pump si rô vanilla',
    if (updatedElement.containsKey('cookie_crumble_topping')) 'cookie_crumble_topping': updatedElement['cookie_crumble_topping'],
  };

  void quantityItem (bool isIncrement, int index) {
    if(isIncrement) {
      CartService().orderList[index]['quantity'] = checkQuantity(CartService().orderList[index]['quantity'] + 1);
    } else {
      CartService().orderList[index]['quantity'] = checkQuantity(CartService().orderList[index]['quantity'] - 1);
    }
    if(CartService().orderList[index]['quantity'] == 0) {
      CartService().orderList.removeWhere((item) => item['quantity'] == 0);
    }
    CartService().total();
    calculate();
    notifyListeners();
  }

  int checkQuantity(int quantity) {
    if(quantity<0) {
      return 0;
    } else if (quantity >10) {
      return 10;
    } else {
      return quantity;
    }
  }

  //payment
  bool _isSelectedCash = true;

  bool get isSelectedCash => _isSelectedCash;
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool _isSelectedDigital = false;

  bool get isSelectedDigital => _isSelectedDigital;

  void optionDelivery(int index) {
    for (var element in DataLocal.deliveryOption) {
      element.isSelected = false;
    }
    DataLocal.deliveryOption[index].isSelected = true;
    notifyListeners();
  }

  void pickCash() {
    _isSelectedCash = true;
    _isSelectedDigital = false;
    notifyListeners();
  }

  void pickDigital() {
    _isSelectedCash = false;
    _isSelectedDigital = true;
    notifyListeners();
  }

  double _deliverCharge = 0 ;
  double get deliverCharge => _deliverCharge;

  double _total = 0;
  double get total => _total;

  void createOrder() {
    CartService().orderEntity = OrderEntity(
        userEntity: AuthService().userEntity,
        items: CartService().orderList,
        createAt: DateTime.now().toString(),
        deliveryCharge: deliverCharge,
        orderAmount: total,
        orderNote: noteController.text,
        address: addressController.text.isNotEmpty ? addressController.text : AuthService().userEntity.address);
  }

  void notificationSuccess(BuildContext context) {
    showDialog(context: context, builder: (context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      }).whenComplete(() {
        CartService().initOrderList();
        CartService().total();
        Navigator.pop(context);
      });
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DimensManager.dimens.setRadius(30)))
        ),
        content: SizedBox(
          height: DimensManager.dimens.setHeight(150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AssetImages.success,
                width: DimensManager.dimens.setWidth(100),
                height: DimensManager.dimens.setHeight(100),
              ),
              UITitle(UIStrings.createOrderSuccess, size: DimensManager.dimens.setSp(16), color: UIColors.text,)
            ],
          ),
        ),
      );
    });
  }

  bool isAddress = true;

  void checkAddress(BuildContext context) {
    createOrder();
    if(CartService().orderEntity.address.isEmpty) {
      isAddress = false;
      notifyListeners();
    } else {
      addOrder(CartService().orderEntity);
      notificationSuccess(context);
      CartService().total();
      notifyListeners();
    }
  }

  void calculate() {
    _deliverCharge = DataLocal.deliveryOption.first.isSelected == true ? 15000 : 0;
    _total =  CartService().totalAmount + deliverCharge;
    notifyListeners();
  }


  Future<void> addOrder(OrderEntity orderEntity) async{
    var collectionRef = FirebaseFirestore.instance.collection('order');
    var querySnapshot = await collectionRef.orderBy('orderId', descending: true).limit(1).get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs[0];
      var docId = doc.id;
      var id = int.parse(docId.substring(docId.lastIndexOf('#')+1));
      final docOrder = collectionRef.doc("#${id+1}");
      orderEntity.orderId = docOrder.id;
      await docOrder.set(orderEntity.toJson());
    } else {
      final docOrder = collectionRef.doc('#1000001');
      orderEntity.orderId = docOrder.id;
      await docOrder.set(orderEntity.toJson());
    }
    notifyListeners();
  }
}