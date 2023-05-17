class CartService {
  static final CartService _cartService = CartService._internal();

  factory CartService() {
    return _cartService;
  }

  List<dynamic> orderList = [];

  int _totalQuantityCart = 0;
  int get totalQuantityCart => _totalQuantityCart;


  void totalCartItem() {
    _totalQuantityCart = orderList.fold(0, (previous, current) => previous + current['quantity'] as int);
  }

  CartService._internal();
}
