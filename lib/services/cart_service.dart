import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:sahami_app/services/auth_service.dart';

class CartService {
  static final CartService _cartService = CartService._internal();

  factory CartService() {
    return _cartService;
  }

  List<dynamic> orderList = [];

  int _totalQuantityCart = 0;
  int get totalQuantityCart => _totalQuantityCart;

  OrderEntity orderEntity = OrderEntity(userEntity: AuthService().userEntity, items: [], address: AuthService().userEntity.address);

  double _totalAmount = 0;
  double get totalAmount => _totalAmount;


  void total() {
    _totalQuantityCart = orderList.fold(0, (previous, current) => previous + current['quantity'] as int);
    _totalAmount = orderList.fold(0, (previous, current) => previous + current['total']);
  }

  void initOrderList() {
    orderList = [];
  }

  CartService._internal();
}
