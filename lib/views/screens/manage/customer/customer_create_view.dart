import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/enitity/user_entity.dart';
import 'package:sahami_app/viewmodel/customer_view_model.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/widget/ui_add_image.dart';
import '../../../../services/navigation_service.dart';
import '../../../constants/dimens_manager.dart';
import '../../../constants/ui_strings.dart';
import '../../../widget/ui_button_primary.dart';
import '../../../widget/ui_button_small.dart';
import '../../../widget/ui_label.dart';
import '../../../widget/ui_label_text_input.dart';
import '../../../widget/ui_text.dart';

class CustomerCreateView extends StatefulWidget {
  const CustomerCreateView({Key? key}) : super(key: key);

  @override
  State<CustomerCreateView> createState() => _CustomerCreateViewState();
}

class _CustomerCreateViewState extends State<CustomerCreateView> {
  int isAddress = 0;
  final CustomerViewModel _customerViewModel = CustomerViewModel();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _customerViewModel)],
      child: Scaffold(
        backgroundColor: UIColors.background,
        appBar: AppBar(
          title: const Text(UIStrings.addNewCustomer),
          backgroundColor: UIColors.primary,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        body: SafeArea(child: Consumer<CustomerViewModel>(
          builder: (_, customer, __) {
            return Container(
              margin: EdgeInsets.all(DimensManager.dimens.setWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAddImage(customer),
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                    _buildInformation(fullName: _nameController, contact: _contactController, email: _emailController),
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensManager.dimens.setHeight(20),
                          vertical: DimensManager.dimens.setWidth(10)),
                      height: DimensManager.dimens.setHeight(150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            DimensManager.dimens.setRadius(10)),
                        color: UIColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: DimensManager.dimens.setHeight(25),
                            child: Row(
                              children: [
                                const UIText("Lê Vy", color: UIColors.black),
                                VerticalDivider(
                                  color: UIColors.text,
                                  thickness: 1,
                                  endIndent: 3,
                                  indent: 3,
                                ),
                                const UIText("0453454536")
                              ],
                            ),
                          ),
                          const UIText("102 Hải Hồ", size: 12),
                          const UIText(
                              "Phường Thanh Bình, Quận Hải Châu, Đà Nẵng",
                              size: 12
                          ),
                          SizedBox(height: DimensManager.dimens.setHeight(5)),
                          Container(
                            padding: EdgeInsets.all(
                                DimensManager.dimens.setHeight(5)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    DimensManager.dimens.setRadius(5)),
                                border: Border.all(
                                    color: UIColors.primary, width: 1)),
                            child: const UIText("Default", size: 12),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                    _buildAddAddress(),
                    SizedBox(height: DimensManager.dimens.setHeight(50)),
                    UIButtonPrimary(
                        text: UIStrings.createCustomer,
                        onPress: () {
                          final customerEntity = UserEntity(
                              userName: _nameController.text,
                              contact: _contactController.text,
                              email: _emailController.text
                          );
                          _customerViewModel.createCustomer(customerEntity);
                          // _productViewModel.setTest();
                        })
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }

  Widget _buildAddImage(CustomerViewModel customerViewModel) {
    return customerViewModel.selectedFileName.isEmpty
        ? UIAddImage(onTap: () {_buildAddImageBottomSheet(customerViewModel);})
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(customerViewModel.file!.path),
                    width: DimensManager.dimens.setWidth(100),
                    height: DimensManager.dimens.setHeight(100),
                    fit: BoxFit.cover),
              ),
              SizedBox(
                width: DimensManager.dimens.setWidth(20),
              ),
              Row(
                children: [
                  UIButtonSmall(
                    text: UIStrings.edit,
                    onPress: () {
                      _buildAddImageBottomSheet(customerViewModel);
                    },
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(10),
                  ),
                  UIButtonSmall(
                      text: UIStrings.delete,
                    onPress: () {

                    },
                  ),
                ],
              )
            ],
          );
  }

  Widget _buildInformation({required TextEditingController fullName, required TextEditingController contact, required TextEditingController email}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
        color: UIColors.white,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(30),
            vertical: DimensManager.dimens.setHeight(30)),
        child: Column(
          children: [
            UILabelTextInput(
              title: UIStrings.fullName,
              controller: fullName,
            ),
            UILabelTextInput(
              title: UIStrings.contact,
              controller: contact,
              inputNumber: true,
            ),
            UILabelTextInput(
              title: UIStrings.email,
              controller: email,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAddress() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        NavigationServices.instance
            .navigationToCustomerAddAddressScreen(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(20),
            vertical: DimensManager.dimens.setHeight(20)),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensManager.dimens.setRadius(10)),
          color: UIColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const UILabel(title: UIStrings.addAddress, notNull: false),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: DimensManager.dimens.setSp(24),
              color: UIColors.text,
            )
          ],
        ),
      ),
    );
  }

  void _buildAddImageBottomSheet(CustomerViewModel customerViewModel) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const UIText(UIStrings.camera),
                onTap: () {
                  customerViewModel.selectFile(false);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const UIText(UIStrings.gallery),
                onTap: () {
                  customerViewModel.selectFile(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
