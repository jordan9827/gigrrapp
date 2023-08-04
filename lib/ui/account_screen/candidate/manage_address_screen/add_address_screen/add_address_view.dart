import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../others/common_app_bar.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/mapbox_address_form_screen/mapbox_address_form_view.dart';
import 'add_address_view_model.dart';

class AddAddressScreenView extends StatelessWidget {
  final String addressType;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final bool isEdit;
  const AddAddressScreenView({
    Key? key,
    this.addressType = "",
    this.address = "",
    this.city = "",
    this.state = "",
    this.isEdit = false,
    this.pinCode = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var appTitle = isEdit ? "edit_address" : "add_address";
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddAddressViewModel(
        address: address,
        addressType: addressType,
        city: city,
        pinCode: pinCode,
        state: state,
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
          size: SizeConfig.margin_padding_50 * 3,
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
}
