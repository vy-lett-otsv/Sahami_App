import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
class CustomerViewModel extends ChangeNotifier{
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

  Future<void> createCustomer(UserEntity userEntity) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('user').child('/${file!.name}');
      UploadTask uploadTask = ref.putFile(File(file!.path));
      await uploadTask.whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
      final docUser = FirebaseFirestore.instance.collection('user').doc();
      userEntity.userId = docUser.id;
      userEntity.image = _imageUrl;
      final json = userEntity.toJson();
      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }
}