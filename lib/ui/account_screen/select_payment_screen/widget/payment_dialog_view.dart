import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../select_payment_mode_view_model.dart';

class PaymentDialogView extends StatefulWidget {
  final SelectPaymentModelViewModel viewModel;
  final MyGigrrsRosterData gigrrsData;
  final Function() onTap;

  const PaymentDialogView({
    Key? key,
    required this.viewModel,
    required this.gigrrsData,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PaymentDialogView> createState() => _PaymentDialogViewState();
}

class _PaymentDialogViewState extends State<PaymentDialogView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var request = widget.gigrrsData.gigsRequestData.first;
    return Dialog(
      alignment: Alignment.center,
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.60,
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_20,
          vertical: SizeConfig.margin_padding_15,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeadingView(),
              _buildUserProfileView(data: request),
              _buildCheckoutView(data: request)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingView() {
    return Column(
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
      ],
    );
  }

  Widget _buildUserProfileView({
    required GigsRequestData data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: SizeConfig.margin_padding_50,
          backgroundImage: NetworkImage(
            data.candidate.imageURL,
          ),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        Text(
          widget.gigrrsData.gigName,
          style: TSB.semiBoldMedium(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
      ],
    );
  }

  Widget _buildCheckoutView({
    required GigsRequestData data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "total_amount".tr(),
          style: TSB.regularMedium(
            textColor: textRegularColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        Text(
          "₹ " + data.offerAmount.toPriceFormat(0),
          style: TSB.bold(
            textSize: SizeConfig.margin_padding_16 * 2,
            textColor: mainPinkColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        LoadingButton(
          action: widget.onTap,
          title: "pay_now",
        ),
        SizedBox(
          height: SizeConfig.margin_padding_10,
        ),
        InkWell(
          onTap: () => locator<NavigationService>().back(),
          child: Text(
            "cancel".tr(),
            style: TSB.regularMedium(
              textColor: textRegularColor,
            ),
          ),
        ),
      ],
    );
  }
}
