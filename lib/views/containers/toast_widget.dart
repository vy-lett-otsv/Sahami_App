import 'package:fluttertoast/fluttertoast.dart';
import '../constants/ui_color.dart';

class ToastWidget {
  ToastWidget._();

  static showToastSuccess({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: UIColors.primaryBackground,
      textColor: UIColors.primary,
      fontSize: 16.0,
    );
  }
}