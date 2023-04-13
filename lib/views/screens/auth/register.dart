import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
import 'package:sahami_app/viewmodel/auth_view_model.dart';
import '../../../enums/fonts.dart';
import '../../../services/navigation_service.dart';
import '../../assets/asset_icons.dart';
import '../../assets/asset_images.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/ui_button_primary.dart';
import '../../widget/ui_text.dart';
import '../../widget/ui_textinput_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final AuthViewModel _authViewModel = AuthViewModel();
  final UserEntity _userEntity = UserEntity(userName: '', contact: '', email: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DimensManager.dimens.setWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              _buildLogo(),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              _buildTextField(_userTextController, _emailTextController,
                  _passwordTextController, _phoneTextController),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              _buildSignUp(
                  context,
                  _userTextController,
                  _emailTextController,
                  _passwordTextController,
                  _phoneTextController,
                  _authViewModel,
                  _userEntity)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLogo() {
  return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(AssetImages.logo,
              width: DimensManager.dimens.setWidth(120)),
          UIText(UIStrings.appName,
              size: DimensManager.dimens.setSp(40),
              fontWeight: FontWeight.w300,
              color: UIColors.primary),
        ],
      ));
}

Widget _buildTextField(TextEditingController user, TextEditingController email,
    TextEditingController pass, TextEditingController phone) {
  return Column(
    children: [
      UITextInputIcon(
        text: UIStrings.userName,
        icon: Icons.person,
        controller: user,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInputIcon(
        text: UIStrings.email,
        icon: Icons.mail,
        controller: email,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInputIcon(
        text: UIStrings.password,
        icon: Icons.key,
        isPassWordType: true,
        controller: pass,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInputIcon(
        text: UIStrings.phone,
        icon: Icons.phone,
        controller: phone,
      ),
    ],
  );
}

Widget _buildSignUp(
    BuildContext context,
    TextEditingController user,
    TextEditingController email,
    TextEditingController pass,
    TextEditingController phone,
    AuthViewModel authViewModel,
    UserEntity userEntity) {
  return Column(
    children: [
      UIButtonPrimary(
          text: UIStrings.signUp,
          onPress: () {
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email.text,
                password: pass.text).then((value) {
                  authViewModel.createUser(userEntity, value.user?.uid, user.text, phone.text, email.text);
                  NavigationServices.instance.navigationToHomeScreen(context);
                }).onError((error, stackTrace) {
              // print("Error ${error.toString()}");
            });
          }),
      SizedBox(height: DimensManager.dimens.setHeight(20)),
      Center(
        child: Text.rich(TextSpan(
            text: UIStrings.isAccount,
            style: TextStyle(
                fontSize: DimensManager.dimens.setSp(18),
                fontFamily: Fonts.Outfit,
                color: UIColors.text),
            children: <InlineSpan>[
              TextSpan(
                  text: UIStrings.signIn,
                  style: TextStyle(
                      fontSize: DimensManager.dimens.setSp(18),
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.Outfit,
                      color: UIColors.text),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NavigationServices.instance
                          .navigationToLoginScreen(context);
                    })
            ])),
      ),
      SizedBox(height: DimensManager.dimens.setHeight(50)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetIcons.iconFacebook,
              width: DimensManager.dimens.setWidth(50)),
          SizedBox(width: DimensManager.dimens.setWidth(50)),
          Image.asset(AssetIcons.iconGoogle,
              width: DimensManager.dimens.setWidth(50))
        ],
      )
    ],
  );
}
