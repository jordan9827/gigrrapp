import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/business_type_drop_down_screen/business_type_drop_down_view.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../widgets/custom_image_picker/custom_image_picker_view.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../../../../widgets/map_box/google_map_box_view.dart';
import '../../../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import '../employer_register_view_model.dart';

class EmployerBusinessInfoFormView
    extends ViewModelWidget<EmployerRegisterViewModel> {
  @override
  Widget build(BuildContext context, EmployerRegisterViewModel viewModel) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.loading,
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
          MapBoxAddressFormViewWidget(
            latLng: viewModel.latLng,
            cityController: viewModel.cityController,
            addressController: viewModel.addressController,
            stateController: viewModel.stateController,
            pinController: viewModel.pinCodeController,
            mapBoxPlace: viewModel.mapBoxPlace,
          ),
          CVMTextFormField(
            title: "add_pin_map",
            formWidget: _buildGoogleMap(viewModel),
          ),
          CVMTextFormField(
            title: "upload_business_pictures",
            formWidget: CustomImagePickerView(
              imageList: viewModel.imageList,
              title: "add_picture_of_your_business",
            ),
          ),
          _buildSpacer(),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.employerCompleteProfileApiCall,
            backgroundColor: mainGrayColor,
            titleColor: independenceColor,
            title: "skip",
          ),
          _buildSpacer(),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.addBusinessProfileApiCall,
            title: "create_profile",
          ),
          _buildSpacer(
            SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_10,
    );
  }

  Widget _buildGoogleMap(EmployerRegisterViewModel viewModel) {
    return viewModel.mapBoxLoading
        ? MapBoxShimmerWidget()
        : GoogleMapBoxScreen(
            lat: viewModel.latLng.lat,
            lng: viewModel.latLng.lng,
          );
  }
}
