import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
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
        body: ListView(
          children: [
            _buildTitle(),
            _buildSupportView(viewModel),
            _buildAskQuestions(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      color: mainWhiteColor,
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "txt_title_help_support".tr(),
            style: TSB.semiBold(textSize: SizeConfig.safeBlockHorizontal * 8.5),
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

  Widget _buildSupportView(HelpSupportScreenViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.margin_padding_15),
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

  Widget _buildAskQuestions(HelpSupportScreenViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.margin_padding_15),
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
          ...List.generate(
            4,
            (index) => _buildExpandable(viewModel),
          )
        ],
      ),
    );
  }

  Widget _buildExpandable(HelpSupportScreenViewModel viewModel) {
    var radius = SizeConfig.margin_padding_15;
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.margin_padding_5),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: radius),
            // onTap: viewModel.onActionVisible,
            title: Text(
              "What is Lorem Ipsum?",
              style: TSB.boldSmall(),
            ),
            trailing: InkWell(
              onTap: viewModel.onActionVisible,
              child: Image.asset(
                viewModel.isVisible ? arrow_drop_up : arrow_drop_down,
                scale: 2.8,
              ),
            ),
          ),
          Visibility(
            visible: viewModel.isVisible,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: radius,
              ),
              child: Divider(
                thickness: 2,
                color: Color(0xff707070),
              ),
            ),
          ),
          Visibility(
            visible: viewModel.isVisible,
            child: AnimatedContainer(
              padding: EdgeInsets.all(radius),
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: mainWhiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                "Lorem ipsum began as scrambled, nonsensical Latin derived from Cicero's 1st-century BC text De Finibus Bonorum et Malorum.",
                style: TSB.regularSmall(textColor: textNoticeColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
