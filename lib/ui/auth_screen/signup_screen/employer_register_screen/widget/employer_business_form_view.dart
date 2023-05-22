import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/business_type_drop_down_screen/business_type_drop_down_view.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../../../../widgets/custom_image_picker/custom_image_picker_view.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../../../../widgets/map_box/google_map_box_view.dart';
import '../employer_register_view_model.dart';

class EmployerBusinessInfoFormView extends StatelessWidget {
  final EmployerRegisterViewModel viewModel;

  const EmployerBusinessInfoFormView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.isBusy,
      showDialogLoading: true,
      child: Scaffold(
        body: _buildFormView(viewModel),
      ),
    );
  }

  Widget _buildFormView(EmployerRegisterViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
          CVMTextFormField(
            title: "business_name",
            hintForm: "i.e. Pakiza Garments",
            controller: viewModel.businessNameController,
          ),
          BusinessTypeDropDownView(
            controller: viewModel.businessTypeController,
          ),
          CVMTextFormField(
            title: "address",
            readOnly: true,
            controller: viewModel.addressController,
            hintForm: "i.e. House no., Street name, Area",
            onTap: viewModel.mapBoxPlace,
          ),
          CVMTextFormField(
            title: "city",
            hintForm: "i.e. Indore",
            controller: viewModel.cityController,
          ),
          CVMTextFormField(
            title: "state",
            hintForm: "i.e. Madhya Pradesh",
            controller: viewModel.stateController,
          ),
          CVMTextFormField(
            title: "pinCode",
            hintForm: "i.e. 452001",
            controller: viewModel.pinCodeController,
          ),
          CVMTextFormField(
            title: "add_pin_map",
            formWidget: _buildGoogleMap(viewModel),
          ),
          CVMTextFormField(
            title: "upload_business_pictures",
            formWidget: CustomImagePickerView(
              imageList: viewModel.imageList,
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          LoadingButton(
            action: viewModel.employerCompleteProfileApiCall,
            backgroundColor: mainGrayColor,
            titleColor: independenceColor,
            title: "SKIP",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          LoadingButton(
            action: viewModel.addBusinessProfileApiCall,
            title: "create_profile",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildGoogleMap(EmployerRegisterViewModel viewModel) {
    var latLng = viewModel.latLng;
    return GoogleMapBoxScreen(
      lat: latLng.latitude.toString(),
      lng: latLng.longitude.toString(),
    );
  }
}
