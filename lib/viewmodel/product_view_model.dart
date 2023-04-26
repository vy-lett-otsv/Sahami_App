import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/enitity/product_entity.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import '../enums/enum.dart';
import '../views/constants/ui_color.dart';
import '../views/screens/manage/product/product_create_view.dart';

class ProductViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  List<ProductEntity> _productList = [];

  List<ProductEntity> get productList => _productList;

  List<ProductEntity> _featureProductList = [];

  List<ProductEntity> get featureProductList => _featureProductList;

  final productCollection =
      FirebaseFirestore.instance.collection("product").get();

  final featureProductCollection = FirebaseFirestore.instance
      .collection('product')
      .where('status', isEqualTo: "feature")
      .get();

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDes = TextEditingController();
  TextEditingController controllerServingSize = TextEditingController();
  TextEditingController controllerSaturatedFat = TextEditingController();
  TextEditingController controllerProtein = TextEditingController();
  TextEditingController controllerSodium = TextEditingController();
  TextEditingController controllerSugar = TextEditingController();
  TextEditingController controllerCaffeine = TextEditingController();
  late TextEditingController categoryController;
  String categoryName = "";

  ProductEntity _productEntity = ProductEntity(productName: "", description: "", price: 0.0, categoryName: "");
  ProductEntity get productEntity => _productEntity;

  void addProduct() {
     _productEntity = ProductEntity(
      productName: controllerName.text,
      description: controllerDes.text,
      price: double.parse(controllerPrice.text),
      categoryName: categoryName,
      servingSize: double.parse(controllerServingSize.text.isEmpty
          ? "0"
          : controllerServingSize.text),
      saturatedFat: double.parse(controllerSaturatedFat.text.isEmpty
          ? "0"
          : controllerSaturatedFat.text),
      protein: double.parse(
          controllerProtein.text.isEmpty ? "0" : controllerProtein.text),
      sodium: double.parse(
          controllerSodium.text.isEmpty ? "0" : controllerSodium.text),
      sugars: double.parse(
          controllerSugar.text.isEmpty ? "0" : controllerSugar.text),
      caffeine: double.parse(
          controllerCaffeine.text.isEmpty ? "0" : controllerCaffeine.text),
    );
  }

  Future<void> fetchProduct(
      Future<QuerySnapshot<Map<String, dynamic>>> data) async {
    _viewState = ViewState.busy;
    QuerySnapshot querySnapshot = await data;
    List<ProductEntity> product = querySnapshot.docs.map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return ProductEntity(
        productName: data['name'],
        description: data['description'],
        price: data['price'],
        categoryName: data['category_name'],
        productId: data['id'],
        image: data['image'],
        priceSale: data['priceSale'],
      );
    }).toList();
    if (data == productCollection) {
      _productList = product;
    } else {
      _featureProductList = product;
    }
    notifyListeners();
    _viewState = ViewState.success;
  }

  final int _selected = 0;

  int get selected => _selected;

  String selectedFileName = '';
  XFile? file;

  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      selectedFileName = file!.name;
      notifyListeners();
    }
  }

  String _imageUrl = " ";

  String get imageUrl => _imageUrl;

  String _category = "";

  String get category => _category;

  final MainViewModel _mainViewModel = MainViewModel();

  Future<void> createProduct(
      ProductEntity product, BuildContext context, String categoryName) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('product').child('/${file!.name}');
    UploadTask uploadTask = ref.putFile(File(file!.path));
    await uploadTask.whenComplete(() => null);
    _imageUrl = await ref.getDownloadURL();
    final docProduct = FirebaseFirestore.instance.collection('product').doc();
    product.productId = docProduct.id;
    product.image = _imageUrl;
    product.categoryName = categoryName;
    _category = categoryName;
    final json = product.toJson();
    await docProduct.set(json);
    fetchProduct(productCollection);
    // if (context.mounted) Navigator.pop(context, product);
    _mainViewModel.updateCurrentTab(BottomBarItem.productView);
  }

  Future<void> goToScreenCreateProductView(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductCreateView()),
    );
    if (context.mounted) {
      createProduct(result, context, category);
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
    fetchProduct(productCollection);
  }

  Future<void> deleteProduct(String documentId) async {
    await FirebaseFirestore.instance
        .collection("product")
        .doc(documentId)
        .delete();
    fetchProduct(productCollection);
  }
}
