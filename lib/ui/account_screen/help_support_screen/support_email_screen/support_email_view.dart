import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/constants.dart';
import '../../../../others/loading_button.dart';
import '../../../../others/text_field_widget.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/custom_drop_down.dart';
import 'support_email_view_model.dart';

class SupportEmailScreenView extends StatefulWidget {
  const SupportEmailScreenView({Key? key}) : super(key: key);

  @override
  State<SupportEmailScreenView> createState() => _SupportEmailScreenViewState();
}

class _SupportEmailScreenViewState extends State<SupportEmailScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SupportEmailViewModel(),
      onViewModelReady: (viewModel) => viewModel.loadContactSubject(),
      builder: (_, viewModel, child) => Scaffold(
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
              _buildSpacer(),
              _buildTitle(),
              _buildSpacer(),
              Text(
                "select_your_subject".tr(),
                style: TSB.regularSmall(),
              ),
              _buildSpacer(
                SizeConfig.margin_padding_5,
              ),
              CustomDropDownWidget(
                hintText: "select_subject",
                itemList: viewModel.contactSubjectList
                    .map((e) => e.name.toUpperCase())
                    .toList(),
                visible: viewModel.isVisible,
                groupValue: viewModel.subjectController.text,
                onVisible: viewModel.onVisibleAction,
                selectSingleItemsAction: viewModel.onItemSelect,
              ),
              _buildSpacer(),
              Text(
                "your_message".tr(),
                style: TSB.regularSmall(),
              ),
              _buildSpacer(
                SizeConfig.margin_padding_5,
              ),
              InputFieldWidget(
                maxLines: 10,
                hint: "type_your_message",
                controller: viewModel.messageController,
              ),
              _buildSpacer(
                SizeConfig.margin_padding_35,
              ),
              _buildSubmitButton(viewModel)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_20,
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

  Widget _buildSubmitButton(SupportEmailViewModel viewModel) {
    return LoadingButton(
      loading: viewModel.isBusy,
      action: viewModel.contactUS,
      title: "ic_cap_send",
    );
  }
}
