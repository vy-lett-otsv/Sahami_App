import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/location_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';
import '../../../widget/ui_label_text_input_icon.dart';

class CustomerAddAddressView extends StatefulWidget {
  const CustomerAddAddressView({Key? key}) : super(key: key);

  @override
  State<CustomerAddAddressView> createState() => _CustomerAddAddressViewState();
}

class _CustomerAddAddressViewState extends State<CustomerAddAddressView> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationViewModel())
      ],
      child: Scaffold(
        backgroundColor: UIColors.background,
        appBar: AppBar(
          title: const Text(UIStrings.addAddress),
          backgroundColor: UIColors.primary,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<LocationViewModel>(
              builder: (_, locationViewModel, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensManager.dimens.setWidth(20),
                        vertical: DimensManager.dimens.setHeight(30)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: DimensManager.dimens.setHeight(50),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: locationViewModel.addressTypeList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      locationViewModel.setAddressTypeIndex(index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: DimensManager.dimens.setWidth(10)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: DimensManager.dimens.setHeight(10),
                                          horizontal: DimensManager.dimens.setWidth(20)
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(5)),
                                          color: Colors.white,
                                          border: Border.all(color: UIColors.border)
                                      ),
                                      child: Icon(
                                        index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                                        color: locationViewModel.addressLocationIndex == index? UIColors.primary : UIColors.text,
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          SizedBox(height: DimensManager.dimens.setHeight(20)),
                          const UILabelTextInputIcon(title: UIStrings.cityDistrict, icon: Icons.location_on_outlined),
                          const UILabelTextInputIcon(title: UIStrings.homeAddress, icon: Icons.location_on_outlined),
                          const UILabelTextInputIcon(title: UIStrings.contactName, icon: Icons.person_2_outlined),
                          const UILabelTextInputIcon(title: UIStrings.contactNumber, icon: Icons.phone_outlined),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const UIText("Set a default"),
                              Switch(
                                  value: light,
                                  activeColor: UIColors.primary,
                                  onChanged: (bool value) {
                                    setState(() {
                                      light = value;
                                    });
                                  }
                              )

                            ],
                          ),
                          SizedBox(height: DimensManager.dimens.setHeight(50)),
                          const UIButtonPrimary(text: UIStrings.saveAddress),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          )
        ),
      ),
    );
  }
}
