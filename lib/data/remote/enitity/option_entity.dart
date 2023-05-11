class OptionEntity {
  String size;
  String ice;
  String sugar;
  int? brownSugarSyrup;
  int? caramelSyrup;
  int? vanillaSyrup;
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
    this.size = 'M',
    this.ice = 'Bình thường',
    this.sugar = 'Bình thường',
    this.brownSugarSyrup,
    this.caramelSyrup,
    this.vanillaSyrup,
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
    'size': size,
    'ice': ice,
    'sugar':sugar,
    'brown_sugar_syrup':brownSugarSyrup,
    'caramel_syrup': caramelSyrup,
    'vanilla_syrup': vanillaSyrup,
    'cookie_crumble_topping':cookieCrumbleTopping,
    'cinnamon_dolce_sprinkles':cinnamonDolceSprinkles,
    'caramel_drizzle': caramelDrizzle,
    'mocha_drizzle': mochaDrizzle,
    'chocolate_cream_cold_foam':chocolateCreamColdFoam,
    'cinnanmon_sweet_cream_cold':cinnanmonSweetCreamCold,
    'salted_caramel_cream_cold_foam': saltedCaramelCreamColdFoam,
    'vanilla_sweet_cream_cold_foam': vanillaSweetCreamColdFoam,
    'cinnamon_power':cinnamonPower,
    'whipped_cream':whippedCream
  };

  factory OptionEntity.fromJson(Map<String, dynamic> json) {
    return OptionEntity(
      size: json['id'],
      ice: json['name'],
      sugar: json['sugars'],
      brownSugarSyrup: json['brown_sugar_syrup'],
      caramelSyrup: json['caramel_syrup'],
      vanillaSyrup: json['vanilla_syrup'],
      cookieCrumbleTopping: json['cookie_crumble_topping'],
      cinnamonDolceSprinkles: json['cinnamon_dolce_sprinkles'],
      caramelDrizzle: json['caramel_drizzle'],
      mochaDrizzle: json['mocha_drizzle'],
      chocolateCreamColdFoam: json['chocolate_cream_cold_foam'],
      cinnanmonSweetCreamCold: json['cinnanmon_sweet_cream_cold'],
      saltedCaramelCreamColdFoam: json['salted_caramel_cream_cold_foam'],
      vanillaSweetCreamColdFoam: json['vanilla_sweet_cream_cold_foam'],
      cinnamonPower: json['cinnamon_power'],
      whippedCream: json['whipped_cream'],
    );
  }
}