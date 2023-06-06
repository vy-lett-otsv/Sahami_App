class ProductEntity {
  String productId;
  final String productName;
  final String description;
  final double price;
  double priceSale;
  int servingSize;
  int saturatedFat;
  int protein;
  int sodium;
  int sugars;
  int caffeine;
  String image;
  final String status;
  String categoryName;

  ProductEntity(
      {this.productId = ' ',
      required this.productName,
      required this.description,
      required this.price,
      this.priceSale = 0,
      this.servingSize = 0,
      this.saturatedFat = 0,
      this.protein = 0,
      this.sodium = 0,
      this.sugars = 0,
      this.caffeine = 0,
      this.image = '',
      this.status = '',
      required this.categoryName});

  Map<String, dynamic> toJson() => {
        'id': productId,
        'name': productName,
        'description': description,
        'price': price,
        'price_sale': priceSale,
        'serving_size': servingSize,
        'saturated_fat': saturatedFat,
        'protein': protein,
        'sodium': sodium,
        'sugars': sugars,
        'caffeine': caffeine,
        'image': image,
        'status': status,
        'category_name': categoryName,
      };

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      productId: json['id'],
      productName: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      priceSale: json['price_sale'].toDouble(),
      servingSize: json['serving_size'].toInt(),
      saturatedFat: json['saturated_fat'].toInt(),
      protein: json['protein'].toInt(),
      sodium: json['sodium'].toInt(),
      sugars: json['sugars'].toInt(),
      caffeine: json['caffeine'].toInt(),
      image: json['image'],
      status: json['status'],
      categoryName: json['category_name'],
    );
  }

  @override
  String toString() {
    return 'ProductEntity{productId: $productId, productName: $productName, description: $description, price: $price, '
        'priceSale: $priceSale, servingSize: $servingSize, saturatedFat: $saturatedFat, protein: $protein,  '
        'sodium: $sodium, sugars: $sugars, caffeine: $caffeine, image: $image, status: $status, categoryName: $categoryName,}';
  }
}
