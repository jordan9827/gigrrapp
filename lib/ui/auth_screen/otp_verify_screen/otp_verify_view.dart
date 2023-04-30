import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:stacked/stacked.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'otp_verify_view_model.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String mobile;
  const OTPVerifyScreen({Key? key, this.mobile = "+91 9111872780"})
      : super(key: key);

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) => viewModel.sentVerifyOTP(widget.mobile),
        viewModelBuilder: () => OTPVerifyScreenModel(mobile: widget.mobile),
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
        });
  }

  Widget _buildHeadingVerifyOTP(OTPVerifyScreenModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      width: MediaQuery.of(context).size.width,
      color: mainPinkColor.withOpacity(0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_35,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_40,
            child: Image.asset(ic_gigrra_name),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Text(
            "otp_verification".tr(),
            style: TSB.boldXLarge(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text(
            "txt_otp_subTitle".tr(),
            style: TSB.regularSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            children: [
              Text(
                widget.mobile,
                style: TSB.semiBoldSmall(),
              ),
              SizedBox(
                width: SizeConfig.margin_padding_5,
              ),
              InkWell(
                onTap: viewModel.navigationToBack,
                child: Text(
                  "change_number".tr(),
                  style: TSB.regularSmall(textColor: mainPinkColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOTPField(OTPVerifyScreenModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_50,
          ),
          PinCodeTextField(
            // onCompleted: viewModel.navigationToHomeView,
            // obscureText: true,
            length: 6, scrollPadding: EdgeInsets.zero,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            animationType: AnimationType.fade,
            enableActiveFill: true,
            cursorColor: mainBlackColor,
            // obscuringCharacter: '*',
            // validator: viewModel.validateInput,
            controller: viewModel.pinController,
            pinTheme: PinTheme(
              activeFillColor: mainGrayColor,
              inactiveFillColor: mainGrayColor,
              fieldHeight: SizeConfig.margin_padding_50,
              fieldWidth: SizeConfig.margin_padding_24 * 1.8,
              // fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
              activeColor: mainGrayColor,
              inactiveColor: mainGrayColor,
              selectedColor: mainGrayColor,
              selectedFillColor: mainGrayColor,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent,
            keyboardType: TextInputType.number,
            animationDuration: const Duration(milliseconds: 300),
            onChanged: (onChanged) {},
            textStyle: const TextStyle(color: Colors.black),
            appContext: context,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_50,
          ),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.verifyOTPCall,
            title: "txt_verify",
          )
        ],
      ),
    );
  }
}
