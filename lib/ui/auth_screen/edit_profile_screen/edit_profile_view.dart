import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_button.dart';
import '../../../others/text_field_widget.dart';
import '../../../util/others/text_styles.dart';
import 'edit_profile_view_model.dart';

class EditProfileScreenView extends StatefulWidget {
  const EditProfileScreenView({Key? key}) : super(key: key);

  @override
  State<EditProfileScreenView> createState() => _EditProfileScreenViewState();
}

class _EditProfileScreenViewState extends State<EditProfileScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "edit_profile",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          padding: edgeInsetsMargin,
          child: ListView(
            children: [
              _buildEditProfileForm(viewModel),
              SizedBox(
                height: SizeConfig.margin_padding_24,
              ),
              _buildSaveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileForm(EditProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_24,
        ),
        _buildForm(
          title: "enter_full_name",
          hintForm: "i.e. Jack Milton",
          controller: viewModel.nameController,
        ),
        _buildForm(
          title: "enter_mobile_no",
          hintForm: "i.e. 989 898 9898",
          controller: viewModel.mobileController,
        ),
        _buildForm(
          title: "enter_full_address",
          hintForm: "i.e. House no., Street name, Area",
          controller: viewModel.addressController,
        ),
        _buildTitle("add_pin_map"),
        _buildGoogleMap(),
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

  Widget _buildForm({
    required String title,
    String hintForm = "",
    TextEditingController? controller,
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
        InputFieldWidget(hint: hintForm, controller: controller),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
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

  Widget _buildSaveButton() {
    return LoadingButton(
      title: "save",
      action: () {},
    );
  }
}
