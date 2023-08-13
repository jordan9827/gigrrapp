import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/loading_button.dart';
import '../../../../others/text_field_widget.dart';
import '../../../../util/others/text_styles.dart';
import '../../../business_type_drop_down_screen/business_type_drop_down_view.dart';
import '../../../widgets/custom_image_picker/custom_image_picker_view.dart';
import '../../../widgets/cvm_text_form_field.dart';
import '../../../widgets/map_box/google_map_box_view.dart';
import '../../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import 'edit_businesses_view_model.dart';

class EditBusinessesScreenView extends StatelessWidget {
  final GetBusinessesData businessData;
  const EditBusinessesScreenView({Key? key, required this.businessData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.initialDataLoad(businessData),
      viewModelBuilder: () => EditBusinessesViewModel(businessData),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "edit_businesses",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          padding: edgeInsetsMargin,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              _buildEditBusinessForm(viewModel),
              SizedBox(
                height: SizeConfig.margin_padding_24,
              ),
              _buildSaveButton(viewModel),
              SizedBox(
                height: SizeConfig.margin_padding_29,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditBusinessForm(EditBusinessesViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BusinessTypeDropDownView(
          controller: viewModel.businessTypeController,
        ),
        _buildTextFormField(
          title: "enter_business_name",
          hintForm: "i.e. Jack Milton",
          controller: viewModel.businessNameController,
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
          title: "upload_Profile_pictures",
          formWidget: CustomImagePickerView(
            title: "add_picture_of_your_profile",
            imageList: viewModel.imageList,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required String title,
    String hintForm = "",
    int maxLength = 30,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
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
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildSaveButton(EditBusinessesViewModel viewModel) {
    return LoadingButton(
      loading: viewModel.isBusy,
      title: "save",
      action: viewModel.updateBusinessProfileApiCall,
    );
  }
}
