import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: "123456",
      );
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
      userEntity.userId = docUser.id;
      userEntity.image = _imageUrl;
      final json = userEntity.toJson();
      await docUser.set(json);

      fetchCustomer();
      if(context.mounted) Navigator.pop(context, userEntity);
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
              user.delete();
            }
          });
        },
    );
    notifyListeners();
  }

  Future<void> goToScreenCreateCustomerView(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerCreateView()),
    );
    if(context.mounted) {
      createCustomer(result, context);
      Flushbar(
        message:  "Success",
        messageColor: UIColors.primary,
        duration:  const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.task_alt,
          color: UIColors.primary,
        ),
        backgroundColor: UIColors.background,
      ).show(context);
    }
    fetchCustomer();
  }
}