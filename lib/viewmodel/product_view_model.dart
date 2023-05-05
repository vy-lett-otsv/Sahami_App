import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/enitity/product_entity.dart';
import 'package:sahami_app/views/screens/home/main_view.dart';
import '../enums/enum.dart';
import '../views/constants/ui_strings.dart';
import '../views/containers/toast_widget.dart';

class ProductViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  List<ProductEntity> _productList = [];

  List<ProductEntity> get productList => _productList;

  List<ProductEntity> _featureProductList = [];

  List<ProductEntity> get featureProductList => _featureProductList;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDes = TextEditingController();
  TextEditingController controllerServingSize = TextEditingController();
  TextEditingController controllerSaturatedFat = TextEditingController();
  TextEditingController controllerProtein = TextEditingController();
  TextEditingController controllerSodium = TextEditingController();
  TextEditingController controllerSugar = TextEditingController();
  TextEditingController controllerCaffeine = TextEditingController();

  String get getControllerName => controllerName.text;

  void addProduct(BuildContext context) {
    final productEntity = ProductEntity(
      productName: controllerName.text,
      description: controllerDes.text,
      price: double.parse(controllerPrice.text),
      categoryName: categoryName,
      servingSize: int.parse(controllerServingSize.text.isEmpty
          ? "0"
          : controllerServingSize.text),
      saturatedFat: int.parse(controllerSaturatedFat.text.isEmpty
          ? "0"
          : controllerSaturatedFat.text),
      protein: int.parse(
          controllerProtein.text.isEmpty ? "0" : controllerProtein.text),
      sodium: int.parse(
          controllerSodium.text.isEmpty ? "0" : controllerSodium.text),
      sugars: int.parse(
          controllerSugar.text.isEmpty ? "0" : controllerSugar.text),
      caffeine: int.parse(
          controllerCaffeine.text.isEmpty ? "0" : controllerCaffeine.text),
    );
    createProduct(
      productEntity,
      context,
      categoryName,
    ).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MainView(
            index: 2,
          ),
        ),
      ),
    );
  }

  late TextEditingController categoryController;
  String categoryName = "";

  Future<void> fetchProducts(String status) async {
    _viewState = ViewState.busy;
    QuerySnapshot querySnapshot;
    if (status == "feature") {
      querySnapshot = await FirebaseFirestore.instance.collection('product').where('status', isEqualTo: "feature").get();
    } else {
      querySnapshot = await FirebaseFirestore.instance.collection("product").get();
    }
    List<ProductEntity> product = querySnapshot.docs.map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return ProductEntity(
        productName: data['name'],
        description: data['description'],
        price: data['price'],
        categoryName: data['category_name'],
        productId: data['id'],
        image: data['image'],
        priceSale: data['priceSale'].toDouble(),
        servingSize: data['serving_size'].toInt(),
        saturatedFat: data['saturated_fat'].toInt(),
        protein: data['protein'].toInt(),
        sodium: data['sodium'].toInt(),
        sugars: data['sugars'].toInt(),
        caffeine: data['caffeine'].toInt(),
      );
    }).toList();
    if (status == "feature") {
      _featureProductList = product;
    } else {
      _productList = product;
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
    await fetchProducts("product");
    ToastWidget.showToastSuccess(message: UIStrings.success);
  }


  Future<void> deleteProduct(BuildContext context, String documentId) async {
    await FirebaseFirestore.instance
        .collection("product")
        .doc(documentId)
        .delete();
    fetchProducts("product");
    if(context.mounted) Navigator.pop(context);
  }

  int _currentProductTab = 0;

  void changeStaffTab(productTab) {
    _currentProductTab = productTab;
  }
}
