class OrderEntity {
  String orderId;
  String nameProduct;
  double price;
  double priceSale;
  String image;
  String size;
  String ice;
  String sugar;
  int brownSugarSyrup;
  int caramelSyrup;
  int vanillaSyrup;
  String? cookieCrumbleTopping;
  int quantity;
  bool? isExist;
  String? time;

  OrderEntity({
    this.orderId = '',
    required this.nameProduct,
    required this.price,
    required this.priceSale,
    required this.image,
    this.size = 'M',
    this.ice = 'Bình thường',
    this.sugar = 'Bình thường',
    this.brownSugarSyrup = 0,
    this.caramelSyrup = 0,
    this.vanillaSyrup = 0,
    this.cookieCrumbleTopping,
    this.quantity = 1,
    this.isExist,
    this.time
  });

  Map<String, dynamic> toJson() => {
        'name_product': nameProduct,
        'price': price,
        'priceSale': priceSale,
        'size': size,
        'ice': ice,
        'sugar': sugar,
        if (brownSugarSyrup != 0) 'brown_sugar_syrup': brownSugarSyrup,
        if (brownSugarSyrup != 0) 'caramel_syrup': caramelSyrup,
        if (brownSugarSyrup != 0) 'vanilla_syrup': vanillaSyrup,
        if (cookieCrumbleTopping != null)
          'cookie_crumble_topping': cookieCrumbleTopping,
        'quantity': quantity
      };

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
        nameProduct: json['name_product'],
        price: json['price'],
        priceSale: json['price_sale'],
        image: json['image'],
        size: json['id'],
        ice: json['name'],
        sugar: json['sugars'],
        brownSugarSyrup: json['brown_sugar_syrup'],
        caramelSyrup: json['caramel_syrup'],
        vanillaSyrup: json['vanilla_syrup'],
        cookieCrumbleTopping: (json['cookie_crumble_topping'] != null)
            ? json['cookie_crumble_topping']
            : null,
        quantity: json['quantity'],
        isExist: json['is_exist'],
        time: json['time'],
    );
  }

  @override
  String toString() {
    return 'OptionEntity{'
        'nameProduct: $nameProduct, '
        'price: $price, '
        'priceSale: $priceSale, '
        'size: $size, '
        'ice: $ice, '
        'sugar: $sugar, '
        'brownSugarSyrup: $brownSugarSyrup, '
        'caramelSyrup: $caramelSyrup, '
        'vanillaSyrup: $vanillaSyrup, '
        'cookieCrumbleTopping: $cookieCrumbleTopping '
        'quantity: $quantity';
  }
}
