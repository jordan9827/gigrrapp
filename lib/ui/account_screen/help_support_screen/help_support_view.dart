import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/loading_screen.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'faq_item_widget.dart';
import 'help_support_view_model.dart';

class HelpSupportScreenView extends StatelessWidget {
  const HelpSupportScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HelpSupportScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "help_support",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: ListView(
            children: [
              _buildTitle(),
              _buildSupportView(viewModel),
              _buildAskQuestions(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      color: mainWhiteColor,
      padding: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "txt_title_help_support".tr(),
            style: TSB.semiBold(
              textSize: SizeConfig.safeBlockHorizontal * 8.5,
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Text(
            "txt_subtitle_help_support".tr(),
            style: TSB.regularMedium(
              textColor: textRegularColor1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportView(
    HelpSupportScreenViewModel viewModel,
  ) {
    return Container(
      margin: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSupportContain(
            image: ic_chat,
            title: "chat",
            subTitle: "chat_content",
            onTap: viewModel.navigationToChatView,
          ),
          SizedBox(
            width: SizeConfig.margin_padding_20,
          ),
          _buildSupportContain(
            image: support_email,
            title: "email",
            subTitle: "support_email_content",
            onTap: viewModel.navigationToSupportEmailView,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportContain({
    required String image,
    required String title,
    required String subTitle,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.margin_padding_13,
            vertical: SizeConfig.margin_padding_15,
          ),
          decoration: BoxDecoration(
            color: mainWhiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image, scale: 3),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              Text(
                title.tr(),
                style: TSB.semiBoldMedium(
                  textColor: textRegularColor1,
                ),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              Text(
                subTitle.tr(),
                textAlign: TextAlign.center,
                style: TSB.regularSmall(
                  textColor: textRegularColor1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAskQuestions(
    HelpSupportScreenViewModel viewModel,
  ) {
    return Container(
      margin: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "help_support_headline_1".tr(),
            style: TSB.semiBoldLarge(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Column(
            children: viewModel.faqData
                .map(
                  (e) => FAQItemWidget(faq: e),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
