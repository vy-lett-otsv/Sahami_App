import '../../data_local.dart';

class OptionEntity {
  String optionId;
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
  String cookieCrumbleTopping;
  int quantity;
  double total;

  OptionEntity({
    this.optionId = '',
    required this.nameProduct,
    required this.price,
    this.priceSale = 0,
    required this.image,
    this.size = 'M',
    this.ice = 'Bình thường',
    this.sugar = 'Bình thường',
    this.brownSugarSyrup = 0,
    this.caramelSyrup = 0,
    this.vanillaSyrup = 0,
    this.cookieCrumbleTopping = 'Cookie Crumble Topping',
    this.quantity = 1,
    this.total = 0
  });

  Map<String, dynamic> toJson() => {
        'image': image,
        'name_product': nameProduct,
        'price': price,
        if (priceSale != 0) 'priceSale': priceSale,
        'size': size,
        if (ice !=  DataLocal.ice.first)'ice': ice,
        if (sugar !=  DataLocal.sugar.first)'sugar': sugar,
        if (brownSugarSyrup != 0) 'brown_sugar_syrup': brownSugarSyrup,
        if (caramelSyrup != 0) 'caramel_syrup': caramelSyrup,
        if (vanillaSyrup != 0) 'vanilla_syrup': vanillaSyrup,
        if (cookieCrumbleTopping !=  DataLocal.cookieCrumbleTopping.first)
          'cookie_crumble_topping': cookieCrumbleTopping,
        'quantity': quantity,
        'total': total
      };

  factory OptionEntity.fromJson(Map<String, dynamic> json) {
    return OptionEntity(
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
        total: json['total']
    );
  }
}
