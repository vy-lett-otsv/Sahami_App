import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
import 'package:sahami_app/views/screens/manage/customer/customer_create_view.dart';
import '../enums/view_state.dart';

class CustomerViewModel extends ChangeNotifier{

  final int _selected = 0;
  int get selected => _selected;

  String selectedFileName = '';
  XFile? file;

  String _imageUrl = " ";
  String get imageUrl => _imageUrl;

  List<UserEntity> _userList =[];
  List<UserEntity> get userList => _userList;

  final UserEntity _customerDetail = UserEntity(userName: "", contact: " ", email: " ");

  UserEntity get customer => _customerDetail;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      selectedFileName = file!.name;
      notifyListeners();
    }
  }

  Future<void> createCustomer(UserEntity userEntity, BuildContext context) async {
      Reference ref = FirebaseStorage.instance.ref().child('user').child('/${file!.name}');
      UploadTask uploadTask = ref.putFile(File(file!.path));
      await uploadTask.whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
      final docUser = FirebaseFirestore.instance.collection('user').doc();
      userEntity.userId = docUser.id;
      userEntity.image = _imageUrl;
      final json = userEntity.toJson();
      await docUser.set(json);
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: "123456"
      );
      fetchCustomer();
      Navigator.pop(context, userEntity);
      // Navigator.pop(context);
  }

  Future <void> fetchCustomer() async {
    _viewState = ViewState.busy;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where('role', isEqualTo: 'user')
        .get();
    List<UserEntity> users = querySnapshot.docs.map((docSnapshot) {

      final data = docSnapshot.data() as Map<String, dynamic>;
      return UserEntity(
          userName: data['name'],
          contact: data['contact'],
          email: data['email'],
          image: data['image'],
          userId: data['id']
      );
    }).toList();
    _userList = users;
    notifyListeners();
    _viewState = ViewState.success;
  }

  Future <void> deleteCustomer(String documentId) async {
    final db = FirebaseFirestore.instance.collection("user").doc(documentId);
    await db.delete().then(
        (doc) {
          fetchCustomer();
          FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
            if (user != null) {
              print(user);
              user.delete();
            }
          });
        },
    );
  }

  Future<void> goToScreenCreateCustomerView(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerCreateView()),
    );
    createCustomer(result, context);
    fetchCustomer();
  }
}