import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/setting_screen/setting_view_model.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/loading_button.dart';
import '../../util/others/text_styles.dart';

class SettingScreenView extends StatefulWidget {
  const SettingScreenView({Key? key}) : super(key: key);

  @override
  State<SettingScreenView> createState() => _SettingScreenViewState();
}

class _SettingScreenViewState extends State<SettingScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: ListView(
          children: [
            _buildProfileView(),
            Container(
              padding: edgeInsetsMargin,
              child: Column(
                children: [
                  _buildAccountView(viewModel),
                  _buildHelpAndSupportView(viewModel),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Container(
              padding: edgeInsetsMargin,
              child: LoadingButton(
                action: () {},
                backgroundColor: mainPinkColor.withOpacity(0.15),
                title: "logout",
                titleColor: mainPinkColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Text(
              textAlign: TextAlign.center,
              "V 1.0.0.1",
              style: TSB.regularMedium(textColor: textRegularColor),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Image.asset(
              ic_gigrra_name,
              height: SizeConfig.margin_padding_40,
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountView(SettingScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          "account".tr(),
          style: TSB.semiBoldMedium(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        _buildListTile(
          leading: ic_notification,
          title: "notifications",
          trailingWidget: Image.asset(
            ic_radio,
            height: SizeConfig.margin_padding_24,
          ),
        ),
        _buildListTile(
          onTap: viewModel.navigationToShareEarnScreen,
          leading: ic_share,
          title: "share_earn",
        ),
        _buildListTile(
          onTap: viewModel.navigationToLanguageScreen,
          leading: ic_share,
          title: "select_language",
        ),
        _buildListTile(
          onTap: viewModel.navigationToPaymentHistoryScreen,
          leading: ic_payment,
          title: "payment_history",
        ),
      ],
    );
  }

  Widget _buildHelpAndSupportView(SettingScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          "help_support".tr(),
          style: TSB.semiBoldMedium(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        _buildListTile(
          leading: ic_about,
          title: "about",
          onTap: viewModel.navigationToAboutScreen,
        ),
        _buildListTile(
          leading: ic_help,
          title: "help_support",
          onTap: viewModel.navigationToHelpSupportScreen,
        ),
        _buildListTile(
          leading: ic_privacy_blck,
          title: "privacy_policy",
          onTap: viewModel.navigationToPrivacyPolicyScreen,
        ),
        _buildListTile(
          leading: ic_terms,
          title: "terms_condition",
        ),
      ],
    );
  }

  Widget _buildListTile({
    required String leading,
    required String title,
    Widget? trailingWidget,
    Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(bottom: SizeConfig.margin_padding_10),
      leading: Container(
        padding: EdgeInsets.all(SizeConfig.margin_padding_10),
        height: SizeConfig.margin_padding_24 * 1.8,
        width: SizeConfig.margin_padding_24 * 1.8,
        decoration: BoxDecoration(
          color: mainBlueColor.withOpacity(0.10),
          borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
        ),
        child: Image.asset(
          leading,
        ),
      ),
      title: Text(
        title.tr(),
        style: TSB.regularMedium(),
      ),
      trailing: trailingWidget ??
          Image.asset(
            ic_arrow_grey,
            height: SizeConfig.margin_padding_15,
          ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(SizeConfig.margin_padding_15),
          width: MediaQuery.of(context).size.width,
          color: mainPinkColor.withOpacity(0.10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ramesh Jain",
                    style: TSB.boldXLarge(textColor: independenceColor),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.margin_padding_10,
                      vertical: SizeConfig.margin_padding_5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: mainPinkColor),
                    ),
                    child: Text(
                      "txt_edit".tr(),
                      style: TSB.regularVSmall(textColor: mainPinkColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.margin_padding_3,
              ),
              Text(
                "+91 9898989898",
                style: TSB.semiBoldSmall(textColor: independenceColor),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(ic_location,
                      height: SizeConfig.margin_padding_20),
                  SizedBox(
                    width: SizeConfig.margin_padding_3,
                  ),
                  Text(
                    "25, Pardeshipura, Near Shiv Mandir, Indore",
                    style: TSB.regularSmall(textColor: textRegularColor),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_2,
        ),
        Container(
          padding: EdgeInsets.all(SizeConfig.margin_padding_10),
          width: MediaQuery.of(context).size.width,
          color: mainPinkColor.withOpacity(0.10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "your_businesses".tr(),
                style: TSB.regularMedium(),
              ),
              Image.asset(
                ic_pink_arrow_forword,
                height: SizeConfig.margin_padding_15,
              )
            ],
          ),
        )
      ],
    );
  }
}
