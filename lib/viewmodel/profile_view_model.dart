import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
    TextEditingController contactController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    Future<void> updateUser() async {
        final docUser = FirebaseFirestore.instance.collection('user').doc(AuthService().userEntity.userId);
        if(contactController.text != AuthService().userEntity.contact) {
            AuthService().userEntity.contact = contactController.text;
        }
        if(addressController.text != AuthService().userEntity.address) {
            AuthService().userEntity.address = addressController.text;
        }
        final json = AuthService().userEntity.toJson();
        await docUser.set(json);
        notifyListeners();
    }

    void initialTextController() {
        contactController.text = AuthService().userEntity.contact;
        addressController.text = AuthService().userEntity.address;
    }


}