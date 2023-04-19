import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';

class AuthViewModel extends ChangeNotifier{
  final bool _isObscure = true;
  bool get isObscure => _isObscure;

  void displayPassword() {
    _isObscure != _isObscure;
    notifyListeners();
  }

  Future<void> createUser(UserEntity userEntity, String? userId, String username, String phone, String email) async {
      String newDocId = userId!;
      final docUser = FirebaseFirestore.instance.collection('user').doc(newDocId);
      userEntity.userId = userId;
      userEntity.userName = username;
      userEntity.contact = phone;
      userEntity.email = email;
      final json = userEntity.toJson();
      await docUser.set(json);
  }


}