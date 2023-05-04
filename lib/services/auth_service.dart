import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/remote/enitity/user_entity.dart';
import 'navigation_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  String _avaAdmin = "";

  String get avaAdmin => _avaAdmin;

  String _userName = "";

  String get userName => _userName;

  String _roleUserEntity = "";

  String get roleUserEntity => _roleUserEntity;


  Future<void> loginUser(
      BuildContext context, String email, String pass) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      AuthService().roleUser(context, value.user!.uid);
    });
  }

  Future<void> registerUser(BuildContext context, String email, String pass,
      String user, String phone, UserEntity userEntity) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      addUserFirestore(userEntity, value.user?.uid, user, phone, email);
      NavigationServices.instance.navigationToHomeScreen(context);
    });
  }

  Future<void> roleUser(BuildContext context, String idUser) async {
    await FirebaseFirestore.instance.collection("user").doc(idUser).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        String role = data['role'];
        _avaAdmin = data['image'];
        _userName = data['name'];
        if (role == "admin") {
          _roleUserEntity = "admin";
        } else {
          _roleUserEntity = "User";
        }
        NavigationServices.instance.navigationToMainScreen(context);
      },
    );
  }

  Future<void> addUserFirestore(UserEntity userEntity, String? userId,
      String username, String phone, String email) async {
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

  AuthService._internal();
}
