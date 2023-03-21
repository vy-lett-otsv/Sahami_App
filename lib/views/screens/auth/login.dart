import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../enums/fonts.dart';
import '../../assets/asset_images.dart';
import '../../constants/ui_color.dart';
import '../../widget/ui_button.dart';
import '../../widget/ui_textinput.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              Container(
                alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(AssetImages.logo, width: DimensManager.dimens.setWidth(100)),
                      UIText(UIStrings.appName, size: 30, fontWeight: FontWeight.w300),
                    ],
                  )
              ),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              UIText(UIStrings.welcome, size: 40, color: UIColors.black, fontWeight: FontWeight.w600),
              UIText(UIStrings.desSignIn, size: 18, color: UIColors.black, fontWeight: FontWeight.w300),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              const UITextInput(
                text: UIStrings.email,
                icon: Icons.mail,
              ),
              SizedBox(height: DimensManager.dimens.setHeight(15)),
              const UITextInput(
                text: UIStrings.password,
                icon: Icons.key,
              ),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              const UIButton(text: UIStrings.login)
            ],
          ),
        ),
      ),
    );
  }
}
