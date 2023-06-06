import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../widgets/cvm_text_form_field.dart';
import 'add_bank_account_view_model.dart';

class AddBankAccountScreenView extends StatefulWidget {
  const AddBankAccountScreenView({Key? key}) : super(key: key);

  @override
  State<AddBankAccountScreenView> createState() =>
      _AddBankAccountScreenViewState();
}

class _AddBankAccountScreenViewState extends State<AddBankAccountScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddBankAccountViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "add_bank_account",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: ListView(
          padding: edgeInsetsMargin,
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            CVMTextFormField(
              title: "Holder Name",
              hintForm: "i.e. Jack Milcon",
              controller: viewModel.holderNameController,
            ),
            CVMTextFormField(
              title: "bank_name",
              hintForm: "i.e. HDFC Bank",
              controller: viewModel.bankNameController,
            ),
            CVMTextFormField(
              title: "account_number",
              hintForm: "i.e. 7894 7895 2664 65",
              controller: viewModel.accountNumberController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CVMTextFormField(
              title: "ifsc_code",
              hintForm: "i.e. HDFC0000025",
              controller: viewModel.ifscCodeController,
              textCapitalization: TextCapitalization.characters,
            ),
            CVMTextFormField(
              title: "account_type",
              hintForm: "i.e. Saving",
              controller: viewModel.accountTypeController,
            ),
            SizedBox(
              height: SizeConfig.margin_padding_35,
            ),
            LoadingButton(
              loading: viewModel.isBusy,
              action: viewModel.addBankAccount,
              title: "submit",
            ),
            SizedBox(
              height: SizeConfig.margin_padding_35,
            ),
          ],
        ),
      ),
    );
  }
}
