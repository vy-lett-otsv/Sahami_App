import 'package:flutter/material.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'dart:async';

import 'package:sahami_app/views/constants/dimens_manager.dart';
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
        () => NavigationServices.instance.navigationToHomeScreen(context)
    );
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaleTransition(
          scale: animation,
          child: SafeArea(
              child: Center(
                child:  Image.asset(AssetImages.logo,
                width: 200,
                height: 200,),
              )
          ),
        )
    );
  }
}
