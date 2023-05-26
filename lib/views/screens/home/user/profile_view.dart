import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/viewmodel/customer_view_model.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';

import '../../../../services/navigation_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final CustomerViewModel _customerViewModel = CustomerViewModel();

  @override
  void initState() {
   _customerViewModel.initialTextController();
   _customerViewModel.fetchProfileUser();
   print(_customerViewModel.userEntityProfile);
    super.initState();
  }

  @override
  void dispose() {
    _customerViewModel.addressProfileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => _customerViewModel)],
        child: Consumer<CustomerViewModel>(
          builder: (_, viewModel, __) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: UIColors.background,
              body: ListView(
                children: [
                  _buildHeader(viewModel),
                  Container(
                    margin: EdgeInsets.only(top: DimensManager.dimens.setHeight(20)),
                    child: Column(
                      children: [
                        _buildInformation(
                            _buildItem(AssetIcons.iconPhone, viewModel.userEntityProfile.contact, true),
                            UIStrings.phone,
                            viewModel.contactProfileController,
                            Icons.phone,
                            UIStrings.updatePhone,
                            viewModel
                        ),
                        _buildItem(AssetIcons.iconProfileEmail, viewModel.userEntityProfile.email, false),
                        _buildInformation(
                            _buildItem(AssetIcons.iconLocation, viewModel.userEntityProfile.address, true),
                            UIStrings.address,
                            viewModel.addressProfileController,
                            Icons.location_on_outlined,
                            UIStrings.update,
                            viewModel
                        ),
                        GestureDetector(
                          onTap: () {
                            // NavigationServices.instance.navigationToLoginScreen(context);
                            AuthService().signOut(context);
                          },
                          child: _buildItem(AssetIcons.iconLogout, UIStrings.logout, false),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildHeader(CustomerViewModel customerViewModel) {
    print(customerViewModel.userEntityProfile.image);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: DimensManager.dimens.setHeight(200),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(DimensManager.dimens.setRadius(30)),
                bottomRight: Radius.circular(DimensManager.dimens.setRadius(30)),
              ),
              color: UIColors.primary),
        ),
        Positioned(
          bottom: DimensManager.dimens.setHeight(20),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: DimensManager.dimens.setRadius(50),
                    backgroundImage: NetworkImage(
                      customerViewModel.userEntityProfile.image,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const UIText(UIStrings.camera),
                                    onTap: () {
                                      customerViewModel.updateImage(false);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const UIText(UIStrings.gallery),
                                    onTap: () {
                                      customerViewModel.updateImage(true);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: UIColors.white,
                            borderRadius: BorderRadius.circular(
                                DimensManager.dimens.setRadius(50)),
                            border:
                                Border.all(width: 1, color: UIColors.background)),
                        padding:
                            EdgeInsets.all(DimensManager.dimens.setRadius(8)),
                        child: Icon(
                          Icons.mode_edit_outline,
                          color: UIColors.text,
                          size: DimensManager.dimens.setSp(18),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(20),
              ),
              UITitle(
                customerViewModel.userEntityProfile.userName,
                color: UIColors.white,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInformation(
      Widget item,
      String title,
      TextEditingController controller,
      IconData icon,
      String textButton,
      CustomerViewModel viewModel,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UITitle(title),
                    const Divider(),
                    TextField(
                      controller: controller,
                      cursorColor: UIColors.primary,
                      decoration: InputDecoration(
                          prefixIcon:  Icon(icon, color: UIColors.primary,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: UIColors.background
                              )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: UIColors.primary
                              )
                          ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  UIButtonPrimary(
                    text: textButton,
                    paddingHorizontal: 40,
                    onPress: () {
                      viewModel.updateUser();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
      child: item,
    );
  }

  Widget _buildItem(
      String icon,
      String content,
      bool arrow,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(20),
          vertical: DimensManager.dimens.setHeight(10)),
      color: UIColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: DimensManager.dimens.setWidth(50),
              ),
              SizedBox(
                width: DimensManager.dimens.setWidth(20),
              ),
              UIText(content),
            ],
          ),
          arrow ? Icon(
            Icons.keyboard_arrow_right,
            color: UIColors.text,
          ):
              Container()
        ],
      ),
    );
  }
}
