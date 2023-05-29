import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/text_styles.dart';
import 'bank_account_view_model.dart';

class BankAccountScreenView extends StatefulWidget {
  const BankAccountScreenView({Key? key}) : super(key: key);

  @override
  State<BankAccountScreenView> createState() => _BankAccountScreenViewState();
}

class _BankAccountScreenViewState extends State<BankAccountScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BankAccountViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "bank_account",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          margin: edgeInsetsMargin,
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              Text(
                "your_save_bank_acc".tr(),
                style: TSB.semiBoldMedium(textColor: independenceColor),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              _buildAccountListView(viewModel),
              SizedBox(
                height: SizeConfig.margin_padding_15,
              ),
              _buildAddAccountView(viewModel)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountListView(BankAccountViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Axis Bank".tr(),
            style: TSB.semiBoldMedium(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_8,
          ),
          Text(
            "account_no".tr(),
            style: TSB.regularSmall(textColor: independenceColor),
          ),
          Text(
            "ifsc".tr(),
            style: TSB.regularSmall(textColor: independenceColor),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          LoadingButton(
            action: () {},
            title: "remove_account",
            titleColor: mainPinkColor,
            backgroundColor: mainPinkColor.withOpacity(0.10),
          )
        ],
      ),
    );
  }

  Widget _buildAddAccountView(BankAccountViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "add_new_account".tr(),
                style: TSB.semiBoldSmall(),
              ),
              Image.asset(
                ic_arrow_grey,
                scale: 2,
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text(
            "to_you_payment_direct_u_bank".tr(),
            style: TSB.regularVSmall(),
          ),
        ],
      ),
    );
  }
}
