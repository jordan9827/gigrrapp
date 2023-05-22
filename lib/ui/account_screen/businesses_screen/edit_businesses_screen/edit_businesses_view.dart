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
import 'edit_businesses_view_model.dart';

class EditBusinessesScreenView extends StatefulWidget {
  final GetBusinessesList businessData;
  const EditBusinessesScreenView({Key? key, required this.businessData})
      : super(key: key);

  @override
  State<EditBusinessesScreenView> createState() =>
      _EditBusinessesScreenViewState();
}

class _EditBusinessesScreenViewState extends State<EditBusinessesScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) =>
          viewModel.initialDataLoad(widget.businessData),
      viewModelBuilder: () => EditBusinessesViewModel(widget.businessData),
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
            children: [
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
        SizedBox(
          height: SizeConfig.margin_padding_24,
        ),
        BusinessTypeDropDownView(
          controller: viewModel.businessTypeController,
        ),
        _buildTextFormField(
          title: "enter_business_name",
          hintForm: "i.e. Jack Milton",
          controller: viewModel.businessNameController,
        ),
        CVMTextFormField(
          title: "enter_business_address",
          readOnly: true,
          controller: viewModel.addressController,
          hintForm: "i.e. House no., Street name, Area",
          onTap: viewModel.mapBoxPlace,
        ),
        CVMTextFormField(
          title: "add_pin_map",
          formWidget: _buildGoogleMap(viewModel),
        ),
        CVMTextFormField(
          title: "upload_business_pictures",
          formWidget: CustomImagePickerView(
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
          padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
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

  Widget _buildGoogleMap(EditBusinessesViewModel viewModel) {
    var latLng = widget.businessData;
    return GoogleMapBoxScreen(
      lat: latLng.latitude.toString(),
      lng: latLng.longitude.toString(),
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
