import 'package:flutter/material.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

import '../../../services/navigation_service.dart';
class SettingAdminView extends StatefulWidget {
  const SettingAdminView({Key? key}) : super(key: key);

  @override
  State<SettingAdminView> createState() => _SettingAdminViewState();
}

class _SettingAdminViewState extends State<SettingAdminView> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const UIText(UIStrings.logout),
          onPressed: () {
            authService.signOut();
            NavigationServices.instance.navigationToLoginScreen(context);
          },
        ),
      ),
    );
  }
}
