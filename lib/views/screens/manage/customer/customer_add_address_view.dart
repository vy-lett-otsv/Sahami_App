import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/location_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';
import '../../../widget/ui_label_text_input_icon.dart';

class CustomerAddAddressView extends StatefulWidget {
  const CustomerAddAddressView({Key? key}) : super(key: key);

  @override
  State<CustomerAddAddressView> createState() => _CustomerAddAddressViewState();
}

class _CustomerAddAddressViewState extends State<CustomerAddAddressView> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  // final LocationViewModel locationViewModel = LocationViewModel();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const LatLng sourceLocation = LatLng(37.42796133580664, -122.085749655962);
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
                      padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(20)),
                            height: DimensManager.dimens.setHeight(250),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                                border: Border.all(color: UIColors.primary, width: 2)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                              child: GoogleMap(
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                markers: {
                                  const Marker(
                                      markerId: MarkerId("source"),
                                      position: sourceLocation
                                  ),
                                },
                              ),
                            ),
                          ),
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
                          const UILabelTextInputIcon(title: UIStrings.deliverAddress, icon: Icons.location_on),
                          const UILabelTextInputIcon(title: UIStrings.deliverAddress, icon: Icons.location_on),
                          const UILabelTextInputIcon(title: UIStrings.deliverAddress, icon: Icons.location_on)
                        ],
                      ),
                    ),
                    Container(
                      height: DimensManager.dimens.setHeight(120),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(DimensManager.dimens.setRadius(40)),
                            topLeft: Radius.circular(DimensManager.dimens.setRadius(40)),
                          ),
                          color: UIColors.backgroundBottom
                      ),
                      child: const UIButtonPrimary(text: UIStrings.saveAddress),
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
