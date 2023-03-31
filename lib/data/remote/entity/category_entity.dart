import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryEntity {
  String id;
  final String name;

  CategoryEntity({this.id = '', required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  //
  // static CategoryEntity fromJson(Map<String, dynamic> json) => CategoryEntity(
  //   id: json['id'],
  //   name: json['name']
  // );
  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'],
      name: json['name'],
    );
  }
}