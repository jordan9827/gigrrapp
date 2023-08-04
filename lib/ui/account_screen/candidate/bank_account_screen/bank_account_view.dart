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

class BankAccountScreenView extends StatelessWidget {
  const BankAccountScreenView({Key? key}) : super(key: key);

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
              _buildSpacer(),
              Text(
                "your_upi_bank_acc".tr(),
                style: TSB.semiBoldMedium(
                  textColor: independenceColor,
                ),
              ),
              _buildSpacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  SizeConfig.margin_padding_15,
                ),
                decoration: BoxDecoration(
                  color: mainWhiteColor,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.margin_padding_10,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HDFC Bank".tr(),
                          style: TSB.semiBoldSmall(),
                        ),
                        _buildSpacer(
                          SizeConfig.margin_padding_5,
                        ),
                        Text(
                          "vxxxx xxxx 1234".tr(),
                          style: TSB.regularSmall(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ic_arrow_grey,
                          scale: 2.5,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _buildSpacer(),
              Text(
                "your_save_bank_acc".tr(),
                style: TSB.semiBoldMedium(
                  textColor: independenceColor,
                ),
              ),
              _buildSpacer(),
              _buildAccountListView(viewModel),
              _buildSpacer(
                SizeConfig.margin_padding_15,
              ),
              _buildAddAccountView(viewModel)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_10,
    );
  }

  Widget _buildAccountListView(
    BankAccountViewModel viewModel,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Axis Bank".tr(),
            style: TSB.semiBoldMedium(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_8,
          ),
          Text(
            "account_no".tr(),
            style: TSB.regularSmall(
              textColor: independenceColor,
            ),
          ),
          Text(
            "ifsc".tr(),
            style: TSB.regularSmall(
              textColor: independenceColor,
            ),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_29,
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

  Widget _buildAddAccountView(
    BankAccountViewModel viewModel,
  ) {
    return InkWell(
      onTap: viewModel.navigationToAddBankAccountView,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          SizeConfig.margin_padding_15,
        ),
        decoration: BoxDecoration(
          color: mainWhiteColor,
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_10,
          ),
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
            _buildSpacer(
              SizeConfig.margin_padding_5,
            ),
            Text(
              "to_you_payment_direct_u_bank".tr(),
              style: TSB.regularVSmall(),
            ),
          ],
        ),
      ),
    );
  }
}
