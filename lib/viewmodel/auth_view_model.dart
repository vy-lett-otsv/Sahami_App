import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../data/remote/entity/user_entity.dart';
import '../services/auth_service.dart';
import '../services/navigation_service.dart';

class AuthViewModel extends ChangeNotifier{
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();

  final UserEntity userEntity = UserEntity(userName: '', contact: '', email: '', tokenDevice: []);


  void login(BuildContext context) {
    AuthService().loginUser(context, email.text, pass.text);
    checkExistToken(context);
  }
   void register(BuildContext context) {
     AuthService().registerUser(context, email.text, pass.text,
         userName.text, phone.text, userEntity);
     checkExistToken(context);
   }

   Future<void> checkExistToken(BuildContext context) async {
     getToken();
     var tokensArray = AuthService().keyFCM;
     await FirebaseFirestore.instance.collection("user").doc(AuthService().userEntity.userId).get().then((docSnapshot) {
       if(docSnapshot.exists) {
         var data = docSnapshot.data();
         List<dynamic> token = data?['tokenDevice'] ?? [];
         if (token.contains(tokensArray)) {
           NavigationServices.instance.navigationToMainScreen(context);
           print("Dô chỗ này");
         } else {
           FirebaseFirestore.instance.collection("user").doc(AuthService().userEntity.userId).update({"tokenDevice":tokensArray});
           print("hay chỗ này huhu");
           NavigationServices.instance.navigationToMainScreen(context);
         }
       }
     });
   }

  String tokenDevice = "";
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenDevice = token!;
      notifyListeners();
      print("Token $tokenDevice");
    });
    AuthService().keyFCM = tokenDevice;
  }
}