import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../data/network/dtos/fetch_bank_detail_response.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import 'add_bank_account_view_model.dart';

class AddBankAccountScreenView extends StatelessWidget {
  final GetBankDetailResponseData data;
  final bool isEdit;
  const AddBankAccountScreenView({
    Key? key,
    this.isEdit = false,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTitle = isEdit ? "edit_bank_acc" : "add_bank_account";
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddBankAccountViewModel(data, isEdit),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          appTitle,
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: ListView(
          padding: edgeInsetsMargin.copyWith(top: 0),
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            CVMTextFormField(
              title: "holder_name",
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
              maxLength: 11,
              title: "ifsc_code",
              hintForm: "i.e. HDFC0000025",
              controller: viewModel.ifscCodeController,
              textCapitalization: TextCapitalization.characters,
            ),
            _buildAccountTypeView(viewModel),
            SizedBox(
              height: SizeConfig.margin_padding_40,
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

  Widget _buildAccountTypeView(AddBankAccountViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
          ),
          child: Text(
            "account_type".tr(),
            style: TSB.regularSmall(),
          ),
        ),
        CustomDropDownWidget(
          hintText: "i.e. Saving",
          visible: viewModel.isVisible,
          itemList: viewModel.accountTypeList,
          onVisible: viewModel.onVisibleAction,
          groupValue: viewModel.accountTypeController.text,
          selectSingleItemsAction: viewModel.onItemSelectForAccountType,
        ),
      ],
    );
  }
}
