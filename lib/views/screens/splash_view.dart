import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
              child:  Image.asset(AssetImages.logo),
            )
        )
    );
  }
}
