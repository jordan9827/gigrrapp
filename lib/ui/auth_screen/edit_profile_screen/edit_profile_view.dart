import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_button.dart';
import '../../../others/text_field_widget.dart';
import '../../../util/others/text_styles.dart';
import '../../widgets/custom_image_picker/custom_image_picker_view.dart';
import '../../widgets/cvm_text_form_field.dart';
import '../../widgets/map_box/google_map_box_view.dart';
import '../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import 'edit_profile_view_model.dart';

class EditProfileScreenView extends StatelessWidget {
  const EditProfileScreenView({Key? key}) : super(key: key);

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
        body: LoadingScreen(
          loading: viewModel.isBusy,
          showDialogLoading: true,
          child: Container(
            padding: edgeInsetsMargin,
            child: ListView(
              children: [
                _buildEditProfileForm(viewModel),
                _buildSpacer(),
                _buildSaveButton(viewModel),
                _buildSpacer(),
                _buildSpacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileForm(EditProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacer(),
        _buildTextFormField(
          title: "enter_full_name",
          hintForm: "i.e. Jack Milton",
          controller: viewModel.fullNameController,
        ),
        _buildTextFormField(
          title: "enter_mobile_no",
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
        _buildTitle("add_pin_map"),
        _buildGoogleMap(viewModel),
        _buildSpacer(),
        CVMTextFormField(
          title: "upload_profile_pictures",
          formWidget: CustomImagePickerView(
            imageCount: 0,
            imageList: viewModel.imageList,
            title: "add_picture_of_your_profile",
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(String val) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_8,
      ),
      child: Text(
        val.tr(),
        style: TSB.regularSmall(),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_20,
    );
  }

  Widget _buildTextFormField({
    required String title,
    String hintForm = "",
    int maxLength = 30,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    Function()? onTap,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
          ),
          child: Text(
            title.tr(),
            style: TSB.regularSmall(),
          ),
        ),
        InputFieldWidget(
          hint: hintForm,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
        ),
        _buildSpacer(
          SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildGoogleMap(EditProfileViewModel viewModel) {
    return viewModel.mapBoxLoading
        ? MapBoxShimmerWidget()
        : GoogleMapBoxScreen(
            lat: viewModel.latLng.lat,
            lng: viewModel.latLng.lng,
          );
  }

  Widget _buildSaveButton(EditProfileViewModel viewModel) {
    return LoadingButton(
      loading: viewModel.isBusy,
      title: "save",
      action: viewModel.editProfileApiCall,
    );
  }
}
