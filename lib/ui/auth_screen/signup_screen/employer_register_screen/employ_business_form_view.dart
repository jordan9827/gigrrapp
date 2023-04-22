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

class EmployBusinessInfoFormView extends StatefulWidget {
  const EmployBusinessInfoFormView({Key? key}) : super(key: key);

  @override
  State<EmployBusinessInfoFormView> createState() =>
      _EmployBusinessInfoFormViewState();
}

class _EmployBusinessInfoFormViewState
    extends State<EmployBusinessInfoFormView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployeRegisterViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(
              flex: 5,
              child: _buildFormView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
          _buildForm(title: "business_name", hintForm: "i.e. Pakiza Garments"),
          _buildForm(title: "business_type", hintForm: "i.e. Shopping Store"),
          _buildForm(
              title: "address", hintForm: "i.e. House no., Street name, Area"),
          _buildForm(title: "city", hintForm: "i.e. Indore"),
          _buildForm(title: "state", hintForm: "i.e. Madhya Pradesh"),
          _buildForm(title: "pinCode", hintForm: "i.e. 452001"),
          _buildForm(title: "add_pin_map", formWidget: _buildGoogleMap()),
          _buildForm(title: "upload_business_pictures", formWidget: SizedBox()),
          LoadingButton(
            action: () {},
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

  Widget _buildAppBar() {
    return FormAppBarWidgetView();
  }
}
