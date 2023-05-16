import '../data/remote/enitity/option_entity.dart';

class CartService {
  static final CartService _cartService = CartService._internal();

  factory CartService() {
    return _cartService;
  }

  List<OptionEntity> orderList = [];

  int _totalQuantityCart = 0;
  int get totalQuantityCart => _totalQuantityCart;

  void totalCartItem() {
    _totalQuantityCart = orderList.map((item) => item.quantity).fold(0, (previous, current) => previous + current);
  }

  CartService._internal();
}
