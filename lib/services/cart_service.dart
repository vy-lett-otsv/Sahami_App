import '../data/remote/enitity/order_entity.dart';

class CartService {
  static final CartService _cartService = CartService._internal();

  factory CartService() {
    return _cartService;
  }

  List<OrderEntity> orderList = [];

  CartService._internal();
}