import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/services/notification_service.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializeLocalNotifications(debug: true);
  await NotificationService().initializeRemoteNotifications(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: UIStrings.appName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: NavigationServices.instance.routeBuilders,
    );
  }
}
