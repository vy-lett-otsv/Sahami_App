import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    FirebaseFirestore.instance.collection("user").doc(idUser).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        String role = data['role'];
        _avaAdmin = data['image'];
        _userName = data['name'];
        print(avaAdmin);
        print(userName);
        if(role == "admin") {
          NavigationServices.instance.navigationToMainAdminScreen(context);
        } else {
          NavigationServices.instance.navigationToHomeScreen(context);
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
