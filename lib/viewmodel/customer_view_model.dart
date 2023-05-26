import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/entity/user_entity.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/containers/toast_widget.dart';
import 'package:sahami_app/views/screens/manage/customer/customer_create_view.dart';
import '../enums/enum.dart';
import '../services/auth_service.dart';
import '../services/navigation_service.dart';
import '../views/constants/ui_strings.dart';

class CustomerViewModel extends ChangeNotifier {
  final int _selected = 0;

  int get selected => _selected;

  String _selectedFileName = '';

  String get selectedFileName => _selectedFileName;
  XFile? file;
  XFile? fileProfile;

  String _imageUrl = " ";

  String get imageUrl => _imageUrl;

  List<UserEntity> _userList = [];

  List<UserEntity> get userList => _userList;

  final UserEntity _customerDetail =
      UserEntity(userName: "", contact: " ", email: " ");

  UserEntity get customer => _customerDetail;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      _selectedFileName = file!.name;
      notifyListeners();
    }
    print(selectedFileName);
  }

  Future<void> createCustomer(
      UserEntity userEntity, BuildContext context) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('user').child('/${file!.name}');
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
    ToastWidget.showToastSuccess(message: UIStrings.success);
  }

  void updateImage(bool imageFrom) async {
    selectFile(imageFrom);
    print(selectedFileName);
    final file = this.file;
    if (file != null) {
      Reference ref = FirebaseStorage.instance.ref().child('user').child('/${file.name}');
      UploadTask uploadTask = ref.putFile(File(file.path));
      await uploadTask.whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(AuthService().userEntity.userId)
          .update({"image": imageUrl});
      notifyListeners();
      await fetchProfileUser();
    }
  }

  UserEntity _userEntityProfile =
      UserEntity(userName: "", contact: "", email: "");

  UserEntity get userEntityProfile => _userEntityProfile;

  Future<void> fetchProfileUser() async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(AuthService().userEntity.userId)
        .get();
    final data = querySnapshot.data() as Map<String, dynamic>;
    _userEntityProfile = UserEntity.fromJson(data);
    print(userEntityProfile);
    notifyListeners();
  }

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  void addCustomer(BuildContext context) {
    final customerEntity = UserEntity(
        userName: nameController.text,
        contact: contactController.text,
        email: emailController.text,
        address: addressController.text);
    createCustomer(customerEntity, context).then((value) =>
        NavigationServices().navigationToMainViewScreen(context, arguments: 1));
  }

  Future<void> fetchCustomer() async {
    _viewState = ViewState.busy;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where('role', isEqualTo: 'user')
        .get();
    List<UserEntity> users = querySnapshot.docs.map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return UserEntity.fromJson(data);
    }).toList();
    _userList = users;
    notifyListeners();
    _viewState = ViewState.success;
  }

  Future<void> deleteCustomer(String documentId) async {
    final db = FirebaseFirestore.instance.collection("user").doc(documentId);
    await db.delete().then(
      (doc) {
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
          if (user != null && user.uid == documentId) {
            try {
              await user.delete();
              print("User deleted successfully.");
            } catch (error) {
              print("Failed to delete user: $error");
            }
          }
        });
      },
    );
    fetchCustomer();
  }

  Future<void> goToScreenCreateCustomerView(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerCreateView()),
    );
    if (context.mounted) {
      createCustomer(result, context);
      Flushbar(
        message: "Success",
        messageColor: UIColors.primary,
        duration: const Duration(seconds: 3),
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

  //profile
  TextEditingController contactProfileController = TextEditingController();
  TextEditingController addressProfileController = TextEditingController();

  final docUserProfile = FirebaseFirestore.instance
      .collection('user')
      .doc(AuthService().userEntity.userId);

  Future<void> updateUser() async {
    if (contactProfileController.text != AuthService().userEntity.contact) {
      AuthService().userEntity.contact = contactProfileController.text;
    }
    if (addressProfileController.text != AuthService().userEntity.address) {
      AuthService().userEntity.address = addressProfileController.text;
    }
    final json = AuthService().userEntity.toJson();
    await docUserProfile.set(json);
    notifyListeners();
  }

  void initialTextController() {
    contactController.text = AuthService().userEntity.contact;
    addressController.text = AuthService().userEntity.address;
  }

  void signOut(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(AuthService().userEntity.userId)
        .update({"tokenDevice": ""});
    AuthService().signOut();
    if (context.mounted) NavigationServices.instance.navigationToLoginScreen(context);
  }
}
