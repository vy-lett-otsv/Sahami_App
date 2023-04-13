import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
import '../services/navigation_service.dart';

class AuthViewModel extends ChangeNotifier{
  final bool _isObscure = true;
  bool get isObscure => _isObscure;

  void displayPassword() {
    _isObscure != _isObscure;
    notifyListeners();
  }

  Future<void> createProduct(UserEntity userEntity, String? userId, String username, String phone, String email) async {
    try {
      String newDocId = userId!;
      final docUser = FirebaseFirestore.instance.collection('user').doc(newDocId);
      userEntity.userId = userId;
      userEntity.userName = username;
      userEntity.contact = phone;
      userEntity.email = email;
      final json = userEntity.toJson();
      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }

  Future<void> roleUser(BuildContext context, String idUser) async {
    final docRef = FirebaseFirestore.instance.collection("user").doc(idUser);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        String role = data['role'];
        if(role == "admin") {
          NavigationServices.instance.navigationToMainAdminScreen(context);
        } else {
          NavigationServices.instance.navigationToHomeScreen(context);
        }
        print(role);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}