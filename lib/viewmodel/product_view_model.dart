import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahami_app/data/remote/entity/category_entity.dart';
import 'package:sahami_app/data/remote/entity/product_entity.dart';
import 'package:sahami_app/services/navigation_service.dart';
import '../enums/enum.dart';
import '../views/constants/ui_strings.dart';
import '../views/containers/toast_widget.dart';

class ProductViewModel extends ChangeNotifier {
  late TextEditingController categoryController;
  String categoryName = "";

  String get getControllerName => controllerName.text;

  final int _selected = 0;

  int get selected => _selected;

  String selectedFileName = '';
  XFile? file;

  String _imageUrl = " ";

  String get imageUrl => _imageUrl;

  String _category = "";

  String get category => _category;

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

  void updateCategory(CategoryEntity categoryEntity) {
    categoryController.text = categoryEntity.categoryName;
    categoryName = categoryEntity.categoryName;
    notifyListeners();
  }


  void addProduct(BuildContext context) {
    final productEntity = ProductEntity(
        productName: controllerName.text,
        description: controllerDes.text,
        price: double.parse(controllerPrice.text),
        categoryName: categoryName
    );
    createProduct(
      productEntity,
      context,
      categoryName,
    ).then((value) {
      ToastWidget.showToastSuccess(message: UIStrings.success);
      NavigationServices().navigationToMainViewScreen(context, arguments: 2);
    }
    );
  }

  Future<void> fetchProducts(String status) async {
    _viewState = ViewState.busy;
    QuerySnapshot querySnapshot;
    if (status == "feature") {
      querySnapshot = await FirebaseFirestore.instance
          .collection('product')
          .where('status', isEqualTo: "feature")
          .get();
    } else {
      querySnapshot =
      await FirebaseFirestore.instance.collection("product").get();
    }
    List<ProductEntity> product = querySnapshot.docs.map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return ProductEntity.fromJson(data);
    }).toList();

    if (status == "feature") {
      _featureProductList = product;
    } else {
      _productList = product;
    }
    notifyListeners();
    _viewState = ViewState.success;
  }

  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      selectedFileName = file!.name;
      notifyListeners();
    }
  }

  Future<void> createProduct(ProductEntity product, BuildContext context,
      String categoryName) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('product').child('/${file!.name}');
    UploadTask uploadTask = ref.putFile(File(file!.path));
    await uploadTask.whenComplete(() => null);
    _imageUrl = await ref.getDownloadURL();
    var collectionRef = FirebaseFirestore.instance.collection('product');
    var querySnapshot =
    await collectionRef.orderBy('id', descending: true).limit(1).get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs[0];
      var docId = doc.id;
      var id = int.parse(docId.substring(docId.lastIndexOf('#') + 1));
      final docOrder = collectionRef.doc("#${id + 1}");
      product.productId = docOrder.id;
      product.image = _imageUrl;
      product.categoryName = categoryName;
      await docOrder.set(product.toJson());
    } else {
      final docOrder = collectionRef.doc('#1000001');
      product.productId = docOrder.id;
      product.image = _imageUrl;
      product.categoryName = categoryName;
      await docOrder.set(product.toJson());
    }
    await fetchProducts("product");
  }

  Future<void> deleteProduct(BuildContext context, String documentId) async {
    await FirebaseFirestore.instance
        .collection("product")
        .doc(documentId)
        .delete();
    fetchProducts("product");
    if (context.mounted) Navigator.pop(context);
  }
}
