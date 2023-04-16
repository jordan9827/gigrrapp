import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../others/constants.dart';
import '../../others/loading_button.dart';
import '../../others/text_field_widget.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder<LoginViewViewModel>.reactive(
      viewModelBuilder: () => LoginViewViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildHeading(),
                ),
                Expanded(
                  flex: 3,
                  child: _buildLoginForm(viewModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Container(
      padding: edgeInsetsMargin,
      width: double.infinity,
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
            height: SizeConfig.margin_padding_10,
          ),
          Text(
            "txt_login_as".tr(),
            style: TSB.semiBoldLarge(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_4,
          ),
          Text(
            "txt_login_STitle".tr(),
            style: TSB.regularMedium(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(LoginViewViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          InputFieldWidget(
            hint: "Enter Mobile Number",
            controller: viewModel.mobileController,
            errorMsgValidation: viewModel.mobileMessage,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          InputFieldWidget(
            hint: "Enter Password",
            controller: viewModel.passwordController,
            errorMsgValidation: viewModel.pwdMessage,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "forgot_password".tr(),
              style: TSB.regularSmall(textColor: independenceColor),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          Spacer(),
          _buildLoginActionButton(viewModel),
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          InkWell(
            onTap: viewModel.navigationToOTPScreen,
            child: Text(
              "login_with_otp".tr(),
              style: TSB.regularSmall(textColor: mainPinkColor),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          Text(
            "continue_with".tr(),
            style: TSB.regularSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          _buildSocialLoginView(),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          _buildSignUpView(),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLoginView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImage(ic_google),
        SizedBox(
          width: SizeConfig.margin_padding_10,
        ),
        _buildImage(ic_facebook),
        SizedBox(
          width: SizeConfig.margin_padding_10,
        ),
        if (Platform.isIOS) _buildImage(ic_apple),
      ],
    );
  }

  Widget _buildImage(String image) {
    return SizedBox(
      height: SizeConfig.margin_padding_40,
      child: Image.asset(image),
    );
  }

  Widget _buildLoginActionButton(LoginViewViewModel viewModel) {
    return SizedBox(
      height: kToolbarHeight * 0.80,
      child: LoadingButton(
        action: viewModel.login,
        child: Center(
          child: Text(
            "txt_login".tr(),
            style: TSB.regularSmall(textColor: mainWhiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "txt_dont_have_an_acc".tr(),
          style: TSB.regularSmall(),
        ),
        Text(
          "sign_up".tr(),
          style: TSB.regularSmall(textColor: mainPinkColor),
        ),
      ],
    );
  }
}
