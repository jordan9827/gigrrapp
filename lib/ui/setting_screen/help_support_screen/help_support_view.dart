import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'help_support_view_model.dart';

class HelpSupportScreenView extends StatefulWidget {
  const HelpSupportScreenView({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreenView> createState() => _HelpSupportScreenViewState();
}

class _HelpSupportScreenViewState extends State<HelpSupportScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HelpSupportScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "email",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Container(
          padding: edgeInsetsMargin,
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              _buildTitle(),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              Text(
                "select_your_subject".tr(),
                style: TSB.regularSmall(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              InputFieldWidget(
                hint: "select_subject",
                controller: viewModel.subjectController,
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              Text(
                "your_message".tr(),
                style: TSB.regularSmall(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              InputFieldWidget(
                maxLines: 10,
                hint: "type_your_message",
                controller: viewModel.messageController,
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              _buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ic_support_email, scale: 2.5),
        SizedBox(
          width: SizeConfig.margin_padding_20,
        ),
        Text(
          "get_help_your_inbox".tr(),
          style: TSB.regularXLarge(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return LoadingButton(action: () {}, title: "ic_cap_send");
  }
}
