import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/remote/enitity/user_entity.dart';
import 'navigation_service.dart';

class AuthService {
  AuthService._();

  static AuthService? _instance;

  static AuthService get instance => AuthService();

  factory AuthService() {
    _instance ??= AuthService._();
    return _instance!;
  }

  String _avaAdmin = "";
  String get avaAdmin => _avaAdmin;

  String _userName = "";
  String get userName => _userName;


  Future<void> roleUser(BuildContext context, String idUser) async {
    await FirebaseFirestore.instance.collection("user").doc(idUser).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        String role = data['role'];
        _avaAdmin = data['image'];
        _userName = data['name'];
        if(role == "admin") {
          NavigationServices.instance.navigationToMainAdminScreen(context);
        } else {
          NavigationServices.instance.navigationToHomeScreen(context);
        }
      },
    );
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
