import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/ui/auth_screen/signup_screen/employer_register_screen/widget/form_app_bar_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import 'employes_register_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersonalInfoFormView extends StatefulWidget {
  const PersonalInfoFormView({Key? key}) : super(key: key);

  @override
  State<PersonalInfoFormView> createState() => _PersonalInfoFormViewState();
}

class _PersonalInfoFormViewState extends State<PersonalInfoFormView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployeRegisterViewModel(),
      builder: (context, viewModel, child) => Scaffold(
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
    );
  }

  Widget _buildFormView(EmployeRegisterViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
          _buildForm(title: "full_name", hintForm: "i.e. Pakiza Garments"),
          _buildForm(title: "mobile_number", hintForm: "i.e. 989 898 9898"),
          _buildForm(
              title: "address", hintForm: "i.e. House no., Street name, Area"),
          _buildForm(title: "city", hintForm: "i.e. Indore"),
          _buildForm(title: "state", hintForm: "i.e. Madhya Pradesh"),
          _buildForm(title: "pinCode", hintForm: "i.e. 452001"),
          _buildForm(title: "add_pin_map", formWidget: _buildGoogleMap()),
          LoadingButton(
            action: viewModel.navigationToBusinessFormView,
            child: Text(
              "NEXT, ADD BUSINESS".tr(),
              style: TSB.regularSmall(textColor: mainWhiteColor),
            ),
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

  Widget _buildForm({
    required String title,
    String hintForm = "",
    TextEditingController? controller,
    Widget? formWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title),
        formWidget != null
            ? formWidget
            : InputFieldWidget(hint: hintForm, controller: controller),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
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

  Widget _buildAppBar(EmployeRegisterViewModel viewModel) {
    return FormAppBarWidgetView(
      isCheck: true,
    );
  }
}
