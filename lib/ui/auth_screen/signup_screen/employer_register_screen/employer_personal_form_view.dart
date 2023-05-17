import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../../../../others/loading_screen.dart';
import '../../../widgets/cvm_text_form_field.dart';
import '../../../widgets/map_box/google_map_box_view.dart';
import 'employer_register_view_model.dart';

class EmployerPersonalInfoFormView extends StatelessWidget {
  final EmployerRegisterViewModel viewModel;

  const EmployerPersonalInfoFormView({Key? key, required this.viewModel})
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
            title: "full_name",
            hintForm: "i.e. Jack Milton",
            controller: viewModel.fullNameController,
          ),
          CVMTextFormField(
            maxLength: 10,
            title: "mobile_number",
            hintForm: "i.e. 989 898 9898",
            controller: viewModel.mobileController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            controller: viewModel.cityController,
            hintForm: "i.e. Indore",
          ),
          CVMTextFormField(
            title: "state",
            controller: viewModel.stateController,
            hintForm: "i.e. Madhya Pradesh",
          ),
          CVMTextFormField(
            title: "pinCode",
            controller: viewModel.pinCodeController,
            hintForm: "i.e. 452001",
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
    var latLng = viewModel.latLng;
    return GoogleMapBoxScreen(
      lat: latLng.latitude.toString(),
      lng: latLng.longitude.toString(),
    );
  }
}
