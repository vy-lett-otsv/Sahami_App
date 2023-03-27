import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../data/remote/entity/category_entity.dart';

class CreateCategoryViewModel{
  Stream<List<CategoryEntity>> readCategory() => FirebaseFirestore.instance
      .collection('category')
      .orderBy('name')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => CategoryEntity.fromJson(doc.data())).toList());

  Future createCategory(CategoryEntity category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc();
    category.id = docCategory.id;
    final json = category.toJson();
    await docCategory.set(json);
  }

  Future updateCategory(CategoryEntity category, String text) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.id);
    await docCategory.update({'name': text});
  }
}