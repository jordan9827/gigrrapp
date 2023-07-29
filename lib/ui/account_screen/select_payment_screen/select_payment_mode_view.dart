import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../data/network/dtos/my_gigs_response.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'select_payment_mode_view_model.dart';

class SelectPaymentModeView extends StatelessWidget {
  final GigsRequestData data;

  SelectPaymentModeView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SelectPaymentModelViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: mainWhiteColor,
        appBar: getAppBar(
          context,
          "select_payment_mode",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Column(
          children: [
            _buildHeadingVerifyOTP(viewModel),
            _buildPaymentList(viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentList(SelectPaymentModelViewModel viewModel) {
    return Expanded(
      child: Container(
        margin: edgeInsetsMargin,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Column(
              children: PaymentMethod.paymentList
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.margin_padding_5,
                        vertical: SizeConfig.margin_padding_5,
                      ),
                      decoration: BoxDecoration(
                        color: mainGrayColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        trailing: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            e.image,
                          ),
                        ),
                        title: Text(
                          e.title.tr(),
                          style: TSB.regularSmall(),
                        ),
                        contentPadding: EdgeInsets.zero,
                        leading: Radio<PaymentMethod>(
                          value: e,
                          activeColor: mainPinkColor,
                          groupValue: viewModel.paymentMethod,
                          onChanged: viewModel.selectPayment,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Spacer(),
            LoadingButton(
              loading: viewModel.isBusy,
              action: () => viewModel.submitPayment(
                viewModel: viewModel,
                data: data,
              ),
              title: "pay",
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingVerifyOTP(
    SelectPaymentModelViewModel viewModel,
  ) {
    return Container(
      padding: edgeInsetsMargin,
      width: SizeConfig.screenWidth,
      color: mainPinkColor.withOpacity(0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_40,
            child: Image.asset(ic_gigrra_name),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text(
            "Choose your Payment Method".tr(),
            style: TSB.boldXLarge(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
        ],
      ),
    );
  }
}
