import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:stacked/stacked.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../../widgets/pin_code_field.dart';
import 'otp_verify_view_model.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String mobile;
  final String roleId;

  const OTPVerifyScreen({
    Key? key,
    required this.mobile,
    this.roleId = "",
  }) : super(key: key);

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => OTPVerifyScreenModel(
        mobile: widget.mobile,
        roleId: widget.roleId,
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildHeadingVerifyOTP(viewModel),
                  ),
                  Expanded(
                    flex: 4,
                    child: _buildOTPField(viewModel),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeadingVerifyOTP(OTPVerifyScreenModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      width: MediaQuery.of(context).size.width,
      color: mainPinkColor.withOpacity(0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpacer(
            SizeConfig.margin_padding_35,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_40,
            child: Image.asset(ic_gigrra_name),
          ),
          _buildSpacer(),
          Text(
            "otp_verification".tr(),
            style: TSB.boldXLarge(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_5,
          ),
          Text(
            "txt_otp_subTitle".tr(),
            style: TSB.regularSmall(),
          ),
          _buildSpacer(),
          Row(
            children: [
              Text(
                "$countryCode ${widget.mobile}",
                style: TSB.semiBoldSmall(),
              ),
              SizedBox(
                width: SizeConfig.margin_padding_5,
              ),
              InkWell(
                onTap: viewModel.navigationToBack,
                child: Text(
                  "change_number".tr(),
                  style: TSB.regularSmall(
                    textColor: mainPinkColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_15,
    );
  }

  Widget _buildOTPField(OTPVerifyScreenModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: Column(
        children: [
          _buildSpacer(
            SizeConfig.margin_padding_50,
          ),
          CVPinCodeTextField(
            readOnly: viewModel.isBusy,
            controller: viewModel.pinController,
            onChanged: (value) => viewModel.verifyOtpApiCall(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_50,
          ),
          LoadingButton(
            progressIndicatorColor: mainBlackColor,
            loading: viewModel.isBusy,
            action: viewModel.enableResend ? viewModel.init : () {},
            title: viewModel.enableResend
                ? "resend_otp_text"
                : "resend_otp_in_text".tr(
                    args: [viewModel.timerText],
                  ),
            backgroundColor: viewModel.enableResend
                ? mainPinkColor
                : mainPinkColor.withOpacity(0.1),
            titleColor:
                viewModel.enableResend ? mainWhiteColor : mainBlackColor,
          ),
          _buildSpacer(
            SizeConfig.margin_padding_24,
          ),
        ],
      ),
    );
  }
}
