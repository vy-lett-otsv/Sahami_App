import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import '../../constants/ui_color.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final MainViewModel _mainViewModel = MainViewModel();

  @override
  void initState() {
    _mainViewModel.bottomBarItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _mainViewModel),
      ],
      child: Consumer<MainViewModel>(builder: (_, mainViewModel, __) {
        return Scaffold(
          body: mainViewModel.pages[mainViewModel.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: UIColors.primary,
            unselectedItemColor: UIColors.text,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: mainViewModel.selectedIndex,
            onTap: mainViewModel.onTapNav,
            type: BottomNavigationBarType.fixed,
            items: AuthService().roleUserEntity == "admin"
                ? const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: UIStrings.statistics,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: UIStrings.customer,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AssetIcons.iconProduct)),
                activeIcon:
                ImageIcon(AssetImage(AssetIcons.iconProductPick)),
                label: UIStrings.product,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: UIStrings.order,
              ),
            ]
                : const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: UIStrings.statistics,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: UIStrings.order,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: UIStrings.customer,
              ),
            ],
          ),
        );
      },)
    );
  }
}
