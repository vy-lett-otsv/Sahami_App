class OptionEntity {
  String nameProduct;
  String size;
  String ice;
  String sugar;
  int brownSugarSyrup;
  int caramelSyrup;
  int vanillaSyrup;
  String? cookieCrumbleTopping;
  String? cinnamonDolceSprinkles;
  String? caramelDrizzle;
  String? mochaDrizzle;
  String? chocolateCreamColdFoam;
  String? cinnanmonSweetCreamCold;
  String? saltedCaramelCreamColdFoam;
  String? vanillaSweetCreamColdFoam;
  String? cinnamonPower;
  String? whippedCream;

  OptionEntity({
    required this.nameProduct,
    this.size = 'M',
    this.ice = 'Bình thường',
    this.sugar = 'Bình thường',
    this.brownSugarSyrup = 0,
    this.caramelSyrup = 0,
    this.vanillaSyrup = 0,
    this.cookieCrumbleTopping,
    this.cinnamonDolceSprinkles,
    this.caramelDrizzle,
    this.mochaDrizzle,
    this.chocolateCreamColdFoam,
    this.cinnanmonSweetCreamCold,
    this.saltedCaramelCreamColdFoam,
    this.vanillaSweetCreamColdFoam,
    this.cinnamonPower,
    this.whippedCream
  });

  Map<String, dynamic> toJson() => {
    'name_product': nameProduct,
    'size': size,
    'ice': ice,
    'sugar':sugar,
    if(brownSugarSyrup != 0) 'brown_sugar_syrup':brownSugarSyrup,
    if(brownSugarSyrup != 0) 'caramel_syrup': caramelSyrup,
    if(brownSugarSyrup != 0) 'vanilla_syrup': vanillaSyrup,
    if(cookieCrumbleTopping != null) 'cookie_crumble_topping': cookieCrumbleTopping,
    // 'cinnamon_dolce_sprinkles':cinnamonDolceSprinkles,
    // 'caramel_drizzle': caramelDrizzle,
    // 'mocha_drizzle': mochaDrizzle,
    // 'chocolate_cream_cold_foam':chocolateCreamColdFoam,
    // 'cinnanmon_sweet_cream_cold':cinnanmonSweetCreamCold,
    // 'salted_caramel_cream_cold_foam': saltedCaramelCreamColdFoam,
    // 'vanilla_sweet_cream_cold_foam': vanillaSweetCreamColdFoam,
    // 'cinnamon_power':cinnamonPower,
    // 'whipped_cream':whippedCream
  };

  factory OptionEntity.fromJson(Map<String, dynamic> json) {
    return OptionEntity(
      nameProduct: json['name_product'],
      size: json['id'],
      ice: json['name'],
      sugar: json['sugars'],
      brownSugarSyrup: json['brown_sugar_syrup'],
      caramelSyrup: json['caramel_syrup'],
      vanillaSyrup: json['vanilla_syrup'],
      cookieCrumbleTopping: (json['cookie_crumble_topping'] != null) ? json['cookie_crumble_topping'] : null,
      // cinnamonDolceSprinkles: json['cinnamon_dolce_sprinkles'],
      // caramelDrizzle: json['caramel_drizzle'],
      // mochaDrizzle: json['mocha_drizzle'],
      // chocolateCreamColdFoam: json['chocolate_cream_cold_foam'],
      // cinnanmonSweetCreamCold: json['cinnanmon_sweet_cream_cold'],
      // saltedCaramelCreamColdFoam: json['salted_caramel_cream_cold_foam'],
      // vanillaSweetCreamColdFoam: json['vanilla_sweet_cream_cold_foam'],
      // cinnamonPower: json['cinnamon_power'],
      // whippedCream: json['whipped_cream'],
    );
  }

  @override
  String toString() {
    return 'OptionEntity{'
        'nameProduct: $nameProduct, '
        'size: $size, '
        'ice: $ice, '
        'sugar: $sugar, '
        'brownSugarSyrup: $brownSugarSyrup, '
        'caramelSyrup: $caramelSyrup, '
        'vanillaSyrup: $vanillaSyrup, '
        'cookieCrumbleTopping: $cookieCrumbleTopping';
  }
}