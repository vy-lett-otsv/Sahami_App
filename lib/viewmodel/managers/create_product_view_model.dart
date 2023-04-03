import '../base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/cross_file.dart';

class CreateProductViewModel extends BaseViewModel{
  final int _selected = 0;
  int get selected => _selected;

  String selectedFileName = '';
  XFile? file;

  @override
  void updateUI() {
    super.updateUI();
  }
  selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
        selectedFileName = file!.name;
        notifyListeners();
    }
    print(file!.name);
  }

  int selectedButton = 0;
  void setSelectedCategory(int? index) {
    selectedButton = index?? selectedButton;
    // updateUI();
    notifyListeners();
  }
}