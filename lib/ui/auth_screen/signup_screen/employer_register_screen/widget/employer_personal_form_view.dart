import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/cvm_text_form_field.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../widgets/map_box/google_map_box_view.dart';
import '../../../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import '../employer_register_view_model.dart';

class EmployerPersonalInfoFormView
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
            title: "full_name",
            hintForm: "i.e. Jack Milton",
            controller: viewModel.fullNameController,
          ),
          CVMTextFormField(
            maxLength: 10,
            readOnly: viewModel.isMobileRead,
            title: "mobile_number",
            hintForm: "i.e. 989 898 9898",
            controller: viewModel.mobileController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
          LoadingButton(
            action: viewModel.navigationToBusinessFormView,
            title: "next_add_business",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
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
