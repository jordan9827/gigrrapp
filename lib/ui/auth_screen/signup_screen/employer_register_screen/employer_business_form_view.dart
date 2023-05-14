import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/business_type_drop_down_screen/business_type_drop_down_view.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/cvm_text_form_field.dart';
import '../../../widgets/toggle_app_bar_widget.dart';
import 'employer_register_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widget/pick_business_image_view.dart';

class EmployerBusinessInfoFormView extends StatefulWidget {
  final String fullName;
  final String mobileNumber;
  const EmployerBusinessInfoFormView(
      {Key? key, required this.fullName, required this.mobileNumber})
      : super(key: key);

  @override
  State<EmployerBusinessInfoFormView> createState() =>
      _EmployerBusinessInfoFormViewState();
}

class _EmployerBusinessInfoFormViewState
    extends State<EmployerBusinessInfoFormView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerRegisterViewModel(
        mobile: widget.mobileNumber,
        fullName: widget.fullName,
      ),
      onViewModelReady: (viewModel) {
        final user = locator<UserAuthResponseData>();
        print("Authorization ${user.accessToken}");
      },
      builder: (context, viewModel, child) => LoadingScreen(
        loading: viewModel.isBusy,
        showDialogLoading: true,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Expanded(
                flex: 5,
                child: _buildFormView(viewModel),
              )
            ],
          ),
        ),
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
            formWidget: _buildGoogleMap(),
          ),
          CVMTextFormField(
            title: "upload_business_pictures",
            formWidget: PickBusinessImageWidget(
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

  Widget _buildGoogleMap() {
    return Container(
      height: SizeConfig.margin_padding_50 * 2.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_20),
        child: GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 1.4746,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String val) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
      child: Text(
        val.tr(),
        style: TSB.regularSmall(),
      ),
    );
  }

  Widget _buildAppBar() {
    return ToggleAppBarWidgetView(
      appBarTitle: "create_your_profile",
      firstTitle: "personal_info",
      secondTitle: "business_info",
    );
  }
}
