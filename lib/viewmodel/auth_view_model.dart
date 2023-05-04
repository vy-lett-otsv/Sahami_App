import 'package:flutter/material.dart';
import '../data/remote/enitity/user_entity.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier{
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();

  final UserEntity userEntity = UserEntity(userName: '', contact: '', email: '');


  void login(BuildContext context) {
    AuthService().loginUser(context, email.text, pass.text);
  }
   void register(BuildContext context) {
     AuthService().registerUser(context, email.text, pass.text,
         userName.text, phone.text, userEntity);
   }
}