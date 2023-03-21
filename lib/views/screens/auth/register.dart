import 'package:flutter/material.dart';
import '../../assets/asset_icons.dart';
import '../../assets/asset_images.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/ui_button.dart';
import '../../widget/ui_text.dart';
import '../../widget/ui_textinput.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
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
              const UITextInput(
                text: UIStrings.userName,
                icon: Icons.person,
              ),
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
              SizedBox(height: DimensManager.dimens.setHeight(15)),
              const UITextInput(
                text: UIStrings.phone,
                icon: Icons.phone,
              ),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              const UIButton(text: UIStrings.logup),
              SizedBox(height: DimensManager.dimens.setHeight(10)),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: UIText(UIStrings.isAccount, color: UIColors.text,)
                ),
              ),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      AssetIcons.iconFacebook,
                      width: DimensManager.dimens.setWidth(50)
                  ),
                  SizedBox(width: DimensManager.dimens.setWidth(50)),
                  Image.asset(
                      AssetIcons.iconGoogle,
                      width: DimensManager.dimens.setWidth(50)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );;
  }
}
