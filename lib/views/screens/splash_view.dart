import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/screens/auth/login_view.dart';
import 'package:sahami_app/views/screens/home/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  final MainViewModel _mainViewModel = MainViewModel();

  @override
  void initState() {
    super.initState();
    _mainViewModel.awaitLogin(mounted, context);
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _mainViewModel,
      child: Consumer<MainViewModel>(
        builder: (_, viewModel, __) {
          print(AuthService().userEntity.userId.isEmpty);
          return AuthService().isLogin
              ? AuthService().userEntity.userId.isEmpty
              ? Scaffold(
            backgroundColor: UIColors.white,
            body: Center(
                child: Image.asset(AssetImages.logo,
                    width: DimensManager.dimens.setWidth(200),
                    height: DimensManager.dimens.setHeight(200))),
          )
              : MainView()
              : const LoginView();
        },
      ),
    );
  }
}