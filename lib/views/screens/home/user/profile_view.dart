import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/viewmodel/profile_view_model.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();

  @override
  void initState() {
   _profileViewModel.initialTextController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => _profileViewModel)],
        child: Consumer<ProfileViewModel>(
          builder: (_, viewModel, __) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: UIColors.background,
              body: ListView(
                children: [
                  _buildHeader(),
                  Container(
                    margin: EdgeInsets.only(top: DimensManager.dimens.setHeight(20)),
                    child: Column(
                      children: [
                        _buildInformation(
                            _buildItem(AssetIcons.iconPhone, AuthService().userEntity.contact, true),
                            UIStrings.phone,
                            viewModel.contactController,
                            Icons.phone,
                            UIStrings.updatePhone,
                            viewModel
                        ),
                        _buildItem(AssetIcons.iconProfileEmail, AuthService().userEntity.email, false),
                        _buildInformation(
                            _buildItem(AssetIcons.iconLocation, AuthService().userEntity.address, true),
                            UIStrings.address,
                            viewModel.addressController,
                            Icons.location_on_outlined,
                            UIStrings.update,
                            viewModel
                        ),
                        GestureDetector(
                          onTap: () {},
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

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: DimensManager.dimens.setHeight(300),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(DimensManager.dimens.setRadius(30)),
                bottomRight:
                    Radius.circular(DimensManager.dimens.setRadius(30)),
              ),
              color: UIColors.primary),
        ),
        Positioned(
          bottom: DimensManager.dimens.setHeight(50),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: DimensManager.dimens.setRadius(60),
                    backgroundImage: NetworkImage(
                      AuthService().userEntity.image,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
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
                  )
                ],
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(20),
              ),
              UITitle(
                AuthService().userEntity.userName,
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
      ProfileViewModel viewModel,
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
