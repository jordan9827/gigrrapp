import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/ui/auth_screen/signup_screen/employer_register_screen/widget/form_app_bar_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/text_styles.dart';
import 'employes_register_view_model.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as auto;

class EmployPersonalInfoFormView extends StatefulWidget {
  const EmployPersonalInfoFormView({Key? key}) : super(key: key);

  @override
  State<EmployPersonalInfoFormView> createState() =>
      _EmployPersonalInfoFormViewState();
}

class _EmployPersonalInfoFormViewState
    extends State<EmployPersonalInfoFormView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerRegisterViewModel(),
      builder: (context, viewModel, child) => LoadingScreen(
        loading: viewModel.isBusy,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(viewModel),
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
          _buildTextFormField(
              title: "full_name",
              hintForm: "i.e. Jack Milton",
              controller: viewModel.fullNameController),
          _buildTextFormField(
            maxLength: 10,
            title: "mobile_number",
            hintForm: "i.e. 989 898 9898",
            controller: viewModel.mobileController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          _buildTextFormField(
            title: "address",
            readOnly: true,
            controller: viewModel.addressController,
            hintForm: "i.e. House no., Street name, Area",
            onTap: viewModel.mapBoxPlace,
          ),
          _buildTextFormField(
            title: "city",
            controller: viewModel.cityController,
            hintForm: "i.e. Indore",
          ),
          _buildTextFormField(
            title: "state",
            controller: viewModel.stateController,
            hintForm: "i.e. Madhya Pradesh",
          ),
          _buildTextFormField(
            title: "pinCode",
            controller: viewModel.pinCodeController,
            hintForm: "i.e. 452001",
          ),
          _buildTextFormField(
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
    return Container(
      height: SizeConfig.margin_padding_50 * 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_20),
        child: GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          markers: viewModel.markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(viewModel.latitude, viewModel.longitude),
            zoom: 1.4746,
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String title,
    String hintForm = "",
    int maxLength = 30,
    bool readOnly = false,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    Widget? formWidget,
    Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
          child: Text(
            title.tr(),
            style: TSB.regularSmall(),
          ),
        ),
        formWidget != null
            ? formWidget
            : InputFieldWidget(
                maxLength: maxLength,
                keyboardType: keyboardType,
                hint: hintForm,
                onTap: onTap,
                readOnly: readOnly,
                controller: controller,
              ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildAppBar(EmployerRegisterViewModel viewModel) {
    return FormAppBarWidgetView(
      isCheck: true,
    );
  }
}
