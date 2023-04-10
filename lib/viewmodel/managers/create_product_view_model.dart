import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahami_app/data/remote/entity/product_entity.dart';
import 'package:sahami_app/viewmodel/managers/create_category_view_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductViewModel extends ChangeNotifier{
  final int _selected = 0;
  int get selected => _selected;

  String selectedFileName = '';
  XFile? file;

  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
        selectedFileName = file!.name;
        notifyListeners();
    }
    print(file!.name);
  }


  String _imageUrl = " ";
  String get imageUrl => _imageUrl;

  CreateCategoryViewModel categoryViewModel = CreateCategoryViewModel();
  Future<void> createProduct(ProductEntity product, String categoryId) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('product').child('/${file!.name}');
      UploadTask uploadTask = ref.putFile(File(file!.path));
      await uploadTask.whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
      final docProduct = FirebaseFirestore.instance.collection('product').doc();
      product.productId = docProduct.id;
      product.image = _imageUrl;
      product.categoryId = categoryId;
      final json = product.toJson();
      await docProduct.set(json);
    } catch (e) {
      print(e);
    }
  }

  void setTest() async{
    final docProduct = FirebaseFirestore.instance;
    await docProduct.collection("product").doc("image1").set({"name": "Chicago"});
  }

}