import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import '../data/remote/entity/user_entity.dart';
import 'navigation_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  String keyFCM = "";

  UserEntity _userEntity = UserEntity(userName: '', contact: '', email: '');
  UserEntity get userEntity => _userEntity;


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
      AuthService().roleUser(context, value.user!.uid);
    });
  }

  Future<void> roleUser(BuildContext context, String idUser) async {
    await FirebaseFirestore.instance.collection("user").doc(idUser).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        _userEntity = UserEntity.fromJson(data);
        String role = data['role'];
        if (role == "admin") {
          _userEntity.role = "admin";
        } else {
          _userEntity.role = "User";
        }
        print("Token login $keyFCM");
        FirebaseFirestore.instance.collection("user").doc(idUser).update({"tokenDevice":keyFCM});
        // _userEntity.tokenDevice = keyFCM;
        NavigationServices.instance.navigationToMainScreen(context);
      },
    );
  }

  Future<void> addUserFirestore(UserEntity userEntity, String? userId, String username, String phone, String email) async {
    String newDocId = userId!;
    final docUser = FirebaseFirestore.instance.collection('user').doc(newDocId);
    userEntity.userId = userId;
    userEntity.userName = username;
    userEntity.contact = phone;
    userEntity.email = email;
    userEntity.image = AssetImages.avaDefault;
    userEntity.address = UIStrings.notYetAddress;
    userEntity.tokenDevice = AuthService().keyFCM;
    final json = userEntity.toJson();
    await docUser.set(json);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  AuthService._internal();
}
