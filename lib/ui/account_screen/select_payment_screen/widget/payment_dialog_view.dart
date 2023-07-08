import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../select_payment_mode_view_model.dart';

class PaymentDialogView extends StatefulWidget {
  final SelectPaymentModelViewModel viewModel;
  const PaymentDialogView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<PaymentDialogView> createState() => _PaymentDialogViewState();
}

class _PaymentDialogViewState extends State<PaymentDialogView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Dialog(
      alignment: Alignment.center,
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_20,
          vertical: SizeConfig.margin_padding_15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "make_payment".tr(),
                style: TSB.semiBoldHeading(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              Text(
                "payment_title".tr(),
                style: TSB.regularMedium(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              Text(
                "payment_title".tr(),
                style: TSB.semiBoldMedium(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              Text(
                "total_amount".tr(),
                style: TSB.regularMedium(
                  textColor: textRegularColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              Text(
                "400".tr(),
                style: TSB.bold(
                  textSize: SizeConfig.margin_padding_16 * 2,
                  textColor: mainPinkColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_15,
              ),
              LoadingButton(
                action: () {},
                title: "pay_now",
              ),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
