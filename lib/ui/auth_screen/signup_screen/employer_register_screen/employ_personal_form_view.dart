import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/ui/auth_screen/signup_screen/employer_register_screen/widget/form_app_bar_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../util/others/text_styles.dart';
import 'employes_register_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          _buildFormField(title: "full_name", hintForm: "i.e. Jack Milton"),
          _buildFormField(
              title: "mobile_number", hintForm: "i.e. 989 898 9898"),
          _buildFormField(
              title: "address", hintForm: "i.e. House no., Street name, Area"),
          _buildFormField(title: "city", hintForm: "i.e. Indore"),
          _buildFormField(title: "state", hintForm: "i.e. Madhya Pradesh"),
          _buildFormField(title: "pinCode", hintForm: "i.e. 452001"),
          _buildFormField(title: "add_pin_map", formWidget: _buildGoogleMap()),
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

  Widget _buildGoogleMap() {
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
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 1.4746,
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String title,
    String hintForm = "",
    TextEditingController? controller,
    Widget? formWidget,
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
            : InputFieldWidget(hint: hintForm, controller: controller),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildAppBar(EmployeRegisterViewModel viewModel) {
    return FormAppBarWidgetView(
      isCheck: true,
    );
  }
}
