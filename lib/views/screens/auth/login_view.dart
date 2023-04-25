import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/auth_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../enums/fonts.dart';
import '../../../services/navigation_service.dart';
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
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _authViewModel),
      ],
      child: Scaffold(
        backgroundColor: UIColors.background,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimensManager.dimens.setWidth(20),
              vertical: DimensManager.dimens.setHeight(10),
            ),
            child: Consumer<AuthViewModel>(
              builder: (_, authViewModel, __) {
                return Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: DimensManager.dimens.setHeight(30)),
                    _buildTextField(authViewModel.email, authViewModel.pass),
                    SizedBox(height: DimensManager.dimens.setHeight(50)),
                    _buildButtonLogin(context, authViewModel)
                  ],
                );
              },
            ),
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
              Image.asset(AssetImages.logo,
                  width: DimensManager.dimens.setWidth(120)),
              UIText(UIStrings.appName,
                  size: DimensManager.dimens.setSp(40),
                  fontWeight: FontWeight.w300,
                  color: UIColors.primary),
            ],
          )),
      SizedBox(height: DimensManager.dimens.setHeight(30)),
      UIText(UIStrings.welcome,
          size: DimensManager.dimens.setSp(40),
          color: UIColors.black,
          fontWeight: FontWeight.w400),
      UIText(UIStrings.desSignIn,
          size: 18, color: UIColors.text, fontWeight: FontWeight.w300),
      SizedBox(height: DimensManager.dimens.setHeight(30)),
    ],
  );
}

Widget _buildTextField(
    TextEditingController email, TextEditingController pass) {
  return Column(
    children: [
      UITextInputIcon(
        text: UIStrings.email,
        icon: Icons.mail,
        controller: email,
        validation: (value) {
          if (value!.length == 0) {
            return "Email cannot be empty";
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid email");
          } else {
            return null;
          }
        },
      ),
      SizedBox(height: DimensManager.dimens.setHeight(15)),
      UITextInputIcon(
        text: UIStrings.password,
        icon: Icons.key,
        controller: pass,
        isPassWordType: true,
        // suffixIcon: IconButton(
        //     icon: Icon( authViewModel.isObscure
        //         ? Icons.visibility
        //         : Icons.visibility_off),
        //     onPressed: () {authViewModel.displayPassword();}),
      ),
    ],
  );
}

Widget _buildButtonLogin(
  BuildContext context,
  AuthViewModel authViewModel,
) {
  return Column(
    children: [
      UIButtonPrimary(
          text: UIStrings.signIn,
          onPress: () {
            authViewModel.login(context);
          }),
      SizedBox(height: DimensManager.dimens.setHeight(20)),
      Center(
        child: Text.rich(
          TextSpan(
            text: UIStrings.noAccount,
            style: TextStyle(
                fontSize: DimensManager.dimens.setSp(18),
                fontFamily: Fonts.Outfit,
                color: UIColors.text),
            children: <InlineSpan>[
              TextSpan(
                text: UIStrings.create,
                style: TextStyle(
                    fontSize: DimensManager.dimens.setSp(18),
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.Outfit,
                    color: UIColors.text),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    NavigationServices.instance
                        .navigationToRegisterScreen(context);
                  },
              )
            ],
          ),
        ),
      ),
    ],
  );
}
