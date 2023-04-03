import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/viewmodel/managers/create_category_view_model.dart';
import 'package:sahami_app/views/screens/manage/manage_create_category_view.dart';
import 'package:sahami_app/views/screens/manage/manage_create_product_view.dart';
import 'package:sahami_app/views/screens/splash_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ManageCreateProductView(),
      // onGenerateRoute: NavigationServices.instance.routeBuilders,
    );
  }
}
