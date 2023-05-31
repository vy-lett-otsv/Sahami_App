import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                horizontal: DimensManager.dimens.setWidth(20)),
            child: Consumer<AuthViewModel>(
              builder: (_, authViewModel, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                    _buildLogo(),
                    SizedBox(height: DimensManager.dimens.setHeight(50)),
                    _buildTextField(
                      authViewModel.userName,
                      authViewModel.email,
                      authViewModel.pass,
                      authViewModel.phone,
                    ),
                    SizedBox(height: DimensManager.dimens.setHeight(50)),
                    _buildSignUp(
                      context,
                      authViewModel,
                    )
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
        text: UIStrings.phoneEn,
        icon: Icons.phone,
        controller: phone,
        isNumber: true,
      ),
    ],
  );
}

Widget _buildSignUp(BuildContext context, AuthViewModel authViewModel) {
  return Column(
    children: [
      UIButtonPrimary(
          text: UIStrings.signUp,
          onPress: () {
            // AuthService().registerUser(context, email.text, pass.text,
            //     user.text, phone.text, userEntity);
            authViewModel.register(context);
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
