import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/screens/auth/register.dart';
import 'package:sahami_app/views/screens/home/home_view.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
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
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
    ],
  );
}

Widget _buildTextField(TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      UITextInput(
        text: UIStrings.email,
        icon: Icons.mail,
        controller: email,
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInput(
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
      UIButton(text: UIStrings.login,
          onPress: () {
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email.text,
                password: pass.text)
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeView()));
            }).onError((error, stackTrace) {
              print("Error ${error.toString()}");
            });
          }),
      SizedBox(height: DimensManager.dimens.setHeight(20)),
      Center(
        child: Text.rich(
            TextSpan(
                text:  UIStrings.noAccount,
                children: <InlineSpan>[
                  TextSpan(
                      text: UIStrings.create,
                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RegisterView())
                        );
                      }
                  )
                ]
            )
        ),
      ),
    ],
  );
}
