import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../others/common_app_bar.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../../../../widgets/map_box/google_map_box_view.dart';
import '../../../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import 'add_address_view_model.dart';
import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';

class AddAddressScreenView extends StatelessWidget {
  final GetAddressResponseData addressData;
  final bool isEdit;
  const AddAddressScreenView({
    Key? key,
    required this.addressData,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var appTitle = isEdit ? "edit_address" : "add_address";
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddAddressViewModel(
        data: addressData,
        isEdit: isEdit,
      ),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          appTitle,
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          margin: edgeInsetsMargin,
          child: ListView(
            children: [
              _buildSpacer(
                SizeConfig.margin_padding_15,
              ),
              _buildSelectAddressType(viewModel),
              MapBoxAddressFormViewWidget(
                latLng: viewModel.latLng,
                cityController: viewModel.cityController,
                addressController: viewModel.addressController,
                stateController: viewModel.stateController,
                pinController: viewModel.pinCodeController,
                mapBoxPlace: viewModel.mapBoxPlace,
              ),
              CVMTextFormField(
                title: "add_pin_map",
                formWidget: _buildGoogleMap(viewModel),
              ),
              _buildDefaultAddressView(viewModel),
              _buildSpacer(),
              LoadingButton(
                loading: viewModel.isBusy,
                action: viewModel.loadSaveAddress,
                title: "submit",
              ),
              _buildSpacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_24,
    );
  }

  Widget _buildDefaultAddressView(
    AddAddressViewModel viewModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          onChanged: viewModel.defaultSwitchAction,
          value: viewModel.defaultAddressSwitch,
          activeColor: mainPinkColor,
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_8,
        ),
        Text(
          "make_default_add".tr(),
          style: TSB.regularSmall(),
        ),
      ],
    );
  }

  Widget _buildSelectAddressType(
    AddAddressViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
          ),
          child: Text(
            "add_address".tr(),
            style: TSB.regularSmall(),
          ),
        ),
        CustomDropDownWidget(
          hintText: "i.e. hourly",
          visible: viewModel.isVisible,
          itemList: viewModel.addressTypeList,
          groupValue: viewModel.addressTypeValue,
          onVisible: viewModel.onVisibleAction,
          selectSingleItemsAction: viewModel.onCostCriteriaSelect,
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildGoogleMap(AddAddressViewModel viewModel) {
    return viewModel.mapBoxLoading
        ? MapBoxShimmerWidget()
        : GoogleMapBoxScreen(
            lat: viewModel.latLng.lat,
            lng: viewModel.latLng.lng,
          );
  }
}
