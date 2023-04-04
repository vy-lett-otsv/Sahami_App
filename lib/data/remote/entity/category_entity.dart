class CategoryEntity {
  String categoryId;
  final String categoryName;

  CategoryEntity({this.categoryId = '', required this.categoryName});

  Map<String, dynamic> toJson() => {'id': categoryId, 'name': categoryName};

  //
  // static CategoryEntity fromJson(Map<String, dynamic> json) => CategoryEntity(
  //   id: json['id'],
  //   name: json['name']
  // );
  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      categoryId: json['id'],
      categoryName: json['name'],
    );
  }
}
