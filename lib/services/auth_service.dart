import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import '../data/remote/entity/user_entity.dart';
import '../views/constants/ui_strings.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  String keyFCM = " ";

  var isLogin = false;

  UserEntity _userEntity = UserEntity(userName: '', contact: '', email: '', tokenDevice: []);
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
    await FirebaseFirestore.instance.collection(UIStrings.user).doc(idUser).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        _userEntity = UserEntity.fromJson(data);
        String role = data[UIStrings.role];
        if (role == UIStrings.adminRole) {
          _userEntity.role = UIStrings.adminRole;
        } else {
          _userEntity.role = UIStrings.user;
        }
        checkExistToken(context);
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
    userEntity.tokenDevice.add(AuthService().keyFCM);
    final json = userEntity.toJson();
    await docUser.set(json);
  }

  Future<void> signOut(BuildContext context) async {
    var tokensArray = AuthService().keyFCM;
    final userRef = FirebaseFirestore.instance.collection("user").doc(AuthService().userEntity.userId);
    await userRef.get().then((docSnapshot) {
      if(docSnapshot.exists) {
        var data = docSnapshot.data();
        List<dynamic> token = data?['tokenDevice'] ?? [];
        if (token.contains(tokensArray)) {
          userRef.update({
            "tokenDevice": FieldValue.arrayRemove([tokensArray]),
          });
        }
      }
    });
    await FirebaseAuth.instance.signOut();
    if (context.mounted) NavigationServices.instance.navigationToLoginScreen(context);
  }

  Future<void> checkExistToken(BuildContext context) async {
    await getToken();
    var tokensArray = AuthService().keyFCM;
    final userRef = FirebaseFirestore.instance.collection("user").doc(AuthService().userEntity.userId);
    userRef.get().then((docSnapshot) {
      if(docSnapshot.exists) {
        var data = docSnapshot.data();
        List<dynamic> token = data?['tokenDevice'] ?? [];
        if (token.contains(tokensArray)) {
          NavigationServices.instance.navigationToMainScreen(context);
        } else {
          userRef.update({
            "tokenDevice": FieldValue.arrayUnion([tokensArray]),
          });
          NavigationServices.instance.navigationToMainScreen(context);
        }
      }
    });
  }

  String tokenDevice = "";
  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenDevice = token!;
    });
    AuthService().keyFCM = tokenDevice;
    print("Token $tokenDevice");
  }

  AuthService._internal();
}
