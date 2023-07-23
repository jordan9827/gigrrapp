import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import '../../../util/enums/latLng.dart';
import '../../../util/others/size_config.dart';
import '../cvm_text_form_field.dart';
import '../map_box/google_map_box_view.dart';

class MapBoxAddressFormViewWidget extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinController;
  final LatLng latLng;
  final Function() mapBoxPlace;
  MapBoxAddressFormViewWidget({
    Key? key,
    required this.latLng,
    required this.addressController,
    required this.cityController,
    required this.stateController,
    required this.pinController,
    required this.mapBoxPlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      children: [
        CVMTextFormField(
          title: "address",
          readOnly: true,
          controller: addressController,
          hintForm: "i.e. House no., Street name, Area",
          onTap: mapBoxPlace,
          suffixIcon: Icon(
            Icons.my_location_outlined,
            color: mainPinkColor,
          ),
        ),
        CVMTextFormField(
          title: "city",
          controller: cityController,
          hintForm: "i.e. Indore",
        ),
        CVMTextFormField(
          title: "state",
          controller: stateController,
          hintForm: "i.e. Madhya Pradesh",
        ),
        CVMTextFormField(
          title: "pinCode",
          controller: pinController,
          hintForm: "i.e. 452001",
        ),
        SizedBox(
          height: SizeConfig.margin_padding_10,
        ),
      ],
    );
  }
}
