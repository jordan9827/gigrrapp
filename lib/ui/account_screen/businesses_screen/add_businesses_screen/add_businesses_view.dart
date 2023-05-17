import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/loading_button.dart';
import '../../../../others/text_field_widget.dart';
import '../../../../util/others/text_styles.dart';
import '../../../auth_screen/signup_screen/employer_register_screen/widget/pick_business_image_view.dart';
import '../../../business_type_drop_down_screen/business_type_drop_down_view.dart';
import '../../../widgets/cvm_text_form_field.dart';
import 'add_businesses_view_model.dart';

class AddBusinessesScreenView extends StatefulWidget {
  const AddBusinessesScreenView({Key? key}) : super(key: key);

  @override
  State<AddBusinessesScreenView> createState() =>
      _AddBusinessesScreenViewState();
}

class _AddBusinessesScreenViewState extends State<AddBusinessesScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddBusinessesViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "add_businesses",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          padding: edgeInsetsMargin,
          child: ListView(
            children: [
              _buildAddBusinessForm(viewModel),
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

  Widget _buildAddBusinessForm(AddBusinessesViewModel viewModel) {
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
          formWidget: _buildGoogleMap(),
        ),
        CVMTextFormField(
          title: "upload_business_pictures",
          formWidget: PickBusinessImageWidget(
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

  Widget _buildSaveButton(AddBusinessesViewModel viewModel) {
    return LoadingButton(
      loading: viewModel.isBusy,
      title: "save",
      action: viewModel.addBusinessProfileApiCall,
    );
  }
}
