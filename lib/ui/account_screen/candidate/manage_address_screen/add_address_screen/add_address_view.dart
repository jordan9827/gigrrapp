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
  const AddAddressScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddAddressViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "add_address",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          margin: edgeInsetsMargin,
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_15,
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
              SizedBox(
                height: SizeConfig.margin_padding_24,
              ),
              LoadingButton(
                action: () {},
                title: "submit",
              )
            ],
          ),
        ),
      ),
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
            "Address Type",
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
