import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../../others/common_app_bar.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import 'add_address_view_model.dart';

class AddAddressScreenView extends StatefulWidget {
  const AddAddressScreenView({Key? key}) : super(key: key);

  @override
  State<AddAddressScreenView> createState() => _AddAddressScreenViewState();
}

class _AddAddressScreenViewState extends State<AddAddressScreenView> {
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
              _buildSelectAddressType(),
              CVMTextFormField(
                title: "address",
                readOnly: true,
                controller: viewModel.addressController,
                hintForm: "i.e. House no., Street name, Area",
                suffixIcon: Icon(
                  Icons.my_location_outlined,
                  color: mainPinkColor,
                ),
                onTap: viewModel.mapBoxPlace,
              ),
              CVMTextFormField(
                title: "city",
                controller: viewModel.cityController,
                hintForm: "i.e. Indore",
              ),
              CVMTextFormField(
                title: "state",
                controller: viewModel.stateController,
                hintForm: "i.e. Madhya Pradesh",
              ),
              CVMTextFormField(
                title: "pinCode",
                controller: viewModel.pinCodeController,
                hintForm: "i.e. 452001",
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

  Widget _buildSelectAddressType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
          child: Text(
            "Address Type",
            style: TSB.regularSmall(),
          ),
        ),
        CustomDropDownWidget(
          hintText: "i.e. Shopping Store",
          itemList: [],
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }
}
