class CategoryEntity {
  String categoryId;
  String categoryName;

  CategoryEntity({this.categoryId = '', required this.categoryName});

  Map<String, dynamic> toJson() => {'id': categoryId, 'name': categoryName};

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      categoryId: json['id'],
      categoryName: json['name'],
    );
  }
}
