import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../enums/fonts.dart';
import '../../assets/asset_images.dart';
import '../../constants/ui_color.dart';
import '../../widget/ui_button_primary.dart';
import '../../widget/ui_textinput_icon.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DimensManager.dimens.setWidth(20),
            vertical: DimensManager.dimens.setHeight(10),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              _buildTextField(_emailTextController, _passwordTextController),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              _buildLogin(context, _emailTextController, _passwordTextController)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: DimensManager.dimens.setHeight(20)),
      Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(AssetImages.logo, width: DimensManager.dimens.setWidth(120)),
              UIText(
                  UIStrings.appName,
                  size: DimensManager.dimens.setSp(40),
                  fontWeight: FontWeight.w300,
                  color: UIColors.primary
              ),
            ],
          )
      ),
      SizedBox(height: DimensManager.dimens.setHeight(30)),
      UIText(
          UIStrings.welcome,
          size: DimensManager.dimens.setSp(40),
          color: UIColors.black,
          fontWeight: FontWeight.w400),
      UIText(UIStrings.desSignIn, size: 18, color: UIColors.text, fontWeight: FontWeight.w300),
      SizedBox(height: DimensManager.dimens.setHeight(30)),
    ],
  );
}

Widget _buildTextField(TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      UITextInputIcon(
        text: UIStrings.email,
        icon: Icons.mail,
        controller: email,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInputIcon(
        text: UIStrings.password,
        icon: Icons.key,
        controller: pass,
        isPassWordType: true,
      ),
    ],
  );
}

Widget _buildLogin(BuildContext context, TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      UIButtonPrimary(
          text: UIStrings.signUp,
          onPress: () {}
      ),
      SizedBox(height: DimensManager.dimens.setHeight(20)),
      Center(
        child: Text.rich(
            TextSpan(
                text:  UIStrings.noAccount,
                style: TextStyle(
                    fontSize: DimensManager.dimens.setSp(18),
                    fontFamily: Fonts.Outfit,
                    color: UIColors.text
                ),
                children: <InlineSpan>[
                  TextSpan(
                      text: UIStrings.create,
                      style: TextStyle(fontSize: DimensManager.dimens.setSp(18),fontWeight: FontWeight.bold, fontFamily: Fonts.Outfit, color: UIColors.text),
                      recognizer: TapGestureRecognizer()..onTap = () {}
                  )
                ]
            )
        ),
      ),
    ],
  );
}