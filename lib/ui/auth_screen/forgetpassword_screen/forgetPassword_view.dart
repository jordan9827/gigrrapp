import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../others/text_field_widget.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'forgetPassword_view_model.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ForgetPasswordViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        body: Column(
          children: [
            _buildHeadingVerifyOTP(viewModel),
            Expanded(
              flex: 5,
              child: _buildForgetPasswordForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgetPasswordForm() {
    return Container(
      padding: edgeInsetsMargin,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_29 * 2,
          ),
          InputFieldWidget(
            hint: 'enter_mobile_no',
          ),
          SizedBox(
            height: SizeConfig.margin_padding_50,
          ),
          LoadingButton(
            action: () {},
            title: "submit",
          )
        ],
      ),
    );
  }

  Widget _buildHeadingVerifyOTP(ForgetPasswordViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.margin_padding_17),
      width: MediaQuery.of(context).size.width,
      color: mainPinkColor.withOpacity(0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_40,
            child: Image.asset(ic_gigrra_name),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Text(
            "forgot_password".tr(),
            style: TSB.boldXLarge(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text(
            "title_forgot_password".tr(),
            style: TSB.regularSmall(),
          ),
        ],
      ),
    );
  }
}
