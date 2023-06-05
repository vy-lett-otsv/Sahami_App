import 'package:flutter/cupertino.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController controller= TextEditingController();

  FocusNode focusNode = FocusNode();
}