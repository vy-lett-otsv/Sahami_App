import 'package:flutter/cupertino.dart';

class AddressViewModel extends ChangeNotifier{
  final List<String> _addressTypeList = ["home", "company", "other"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressLocationIndex = 0;
  int get addressLocationIndex => _addressLocationIndex;
  void setAddressTypeIndex (int index) {
    _addressLocationIndex = index;
    notifyListeners();
  }
}