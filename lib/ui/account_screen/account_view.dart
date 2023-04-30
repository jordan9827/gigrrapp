import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/loading_button.dart';
import '../../util/others/text_styles.dart';
import 'account_view_model.dart';
import 'widget/profile_widget_screen.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AccountViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: ListView(
          children: [
            ProfileWidgetScreen(viewModel: viewModel),
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
                loading: viewModel.isBusy,
                action: viewModel.logOut,
                progressIndicatorColor: mainPinkColor,
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
              viewModel.platformVersion,
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

  Widget _buildAccountView(AccountViewModel viewModel) {
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
          trailingWidget: Switch(
            value: viewModel.notificationSwitch,
            activeColor: mainPinkColor,
            onChanged: viewModel.notificationSwitchAction,
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

  Widget _buildHelpAndSupportView(AccountViewModel viewModel) {
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
      trailing: InkWell(
        onTap: onTap,
        child: trailingWidget ??
            Image.asset(
              ic_arrow_grey,
              height: SizeConfig.margin_padding_15,
            ),
      ),
    );
  }
}
