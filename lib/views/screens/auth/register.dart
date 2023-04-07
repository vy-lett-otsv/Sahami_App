import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../assets/asset_icons.dart';
import '../../assets/asset_images.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/ui_button_primary.dart';
import '../../widget/ui_text.dart';
import '../../widget/ui_textinput_icon.dart';
import '../home/home_view.dart';
import 'login.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
              _buildLogo(),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              _buildTextField(_emailTextController, _passwordTextController),
              SizedBox(height: DimensManager.dimens.setHeight(50)),
              _buildSignUp(context, _emailTextController, _passwordTextController)
            ],
          ),
        ),
      ),
    );;
  }
}

Widget _buildLogo() {
  return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(AssetImages.logo, width: DimensManager.dimens.setWidth(100)),
          UIText(UIStrings.appName, size: 30, fontWeight: FontWeight.w300),
        ],
      )
  );
}

Widget _buildTextField(TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      const UITextInputIcon(
        text: UIStrings.userName,
        icon: Icons.person,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(30)),
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
      const UITextInputIcon(
        text: UIStrings.phone,
        icon: Icons.phone,
      ),
    ],
  );
}

Widget _buildSignUp(BuildContext context, TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      UIButtonPrimary(text: UIStrings.logup,
      onPress: () {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: pass.text)
            .then((value) {
          print("Created New Account");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeView()));
        }).onError((error, stackTrace) {
          print("Error ${error.toString()}");
        });
      }),
      SizedBox(height: DimensManager.dimens.setHeight(10)),
      Container(
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
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
  );
}
