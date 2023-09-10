import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/loading_button.dart';
import '../../util/others/text_styles.dart';
import 'account_view_model.dart';
import 'widget/profile_widget_screen.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AccountViewModel(),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () => Future.sync(viewModel.onWillPop),
        child: Scaffold(
          body: LoadingScreen(
            showDialogLoading: true,
            loading: viewModel.isBusy,
            child: ListView(
              children: [
                ProfileWidgetScreen(viewModel: viewModel),
                Container(
                  padding: edgeInsetsMargin,
                  child: Column(
                    children: [
                      if (viewModel.user.isEmployer)
                        _buildBusinessesView(viewModel),
                      _buildAccountView(viewModel, context),
                      _buildHelpAndSupportView(viewModel),
                    ],
                  ),
                ),
                _buildSpacer(),
                Container(
                  padding: edgeInsetsMargin,
                  child: LoadingButton(
                    loading: viewModel.loading,
                    action: viewModel.logOut,
                    progressIndicatorColor: mainPinkColor,
                    backgroundColor: mainPinkColor.withOpacity(0.10),
                    title: "logout",
                    titleColor: mainPinkColor,
                  ),
                ),
                _buildSpacer(),
                Text(
                  textAlign: TextAlign.center,
                  viewModel.platformVersion,
                  style: TSB.regularMedium(
                    textColor: textRegularColor,
                  ),
                ),
                _buildSpacer(),
                Image.asset(
                  ic_gigrra_name,
                  height: SizeConfig.margin_padding_40,
                ),
                _buildSpacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessesView(AccountViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacer(
          SizeConfig.margin_padding_15,
        ),
        Text(
          "businesses".tr(),
          style: TSB.semiBoldMedium(),
        ),
        _buildSpacer(
          SizeConfig.margin_padding_13,
        ),
        _buildListTile(
          padding: SizeConfig.margin_padding_3 * 2,
          leading: ic_businesses_2,
          title: "your_businesses",
          onTap: viewModel.navigationToBusinessesScreen,
        ),
      ],
    );
  }

  Widget _buildAccountView(AccountViewModel viewModel, BuildContext context) {
    var isEmployer = viewModel.user.isEmployer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacer(
          SizeConfig.margin_padding_13,
        ),
        Text(
          "account".tr(),
          style: TSB.semiBoldMedium(),
        ),
        _buildSpacer(
          SizeConfig.margin_padding_13,
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
        if (!isEmployer)
          _buildListTile(
            onTap: viewModel.navigationToBankAccountScreen,
            leading: ic_bank_account,
            title: "bank_account",
          ),
        _buildListTile(
          onTap: viewModel.navigationToShareEarnScreen,
          leading: ic_share,
          title: "share_earn",
        ),
        if (!isEmployer)
          _buildListTile(
            onTap: viewModel.navigationToManageAddressScreen,
            leading: ic_address,
            title: "manage_address",
          ),
        _buildListTile(
          onTap: viewModel.navigationToLanguageScreen,
          leading: ic_language,
          title: "select_language",
        ),
        _buildListTile(
          onTap: viewModel.navigationToPaymentHistoryScreen,
          leading: ic_payment,
          title: "payment_history",
        ),
        _buildListTile(
          onTap: () => viewModel.showDeleteAccountDialog(context),
          leading: ic_remove_wht,
          color: Colors.red,
          title: "delete_acc",
        ),
      ],
    );
  }

  Widget _buildHelpAndSupportView(AccountViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacer(
          SizeConfig.margin_padding_15,
        ),
        Text(
          "help_support".tr(),
          style: TSB.semiBoldMedium(),
        ),
        _buildSpacer(
          SizeConfig.margin_padding_15,
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
          onTap: viewModel.navigationToTermsAndConditionScreen,
        ),
      ],
    );
  }

  Widget _buildListTile({
    required String leading,
    required String title,
    Widget? trailingWidget,
    Color? color,
    double? padding,
    Function()? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_10,
      ),
      leading: Container(
        padding: EdgeInsets.all(
          padding ?? SizeConfig.margin_padding_10,
        ),
        height: SizeConfig.margin_padding_24 * 1.8,
        width: SizeConfig.margin_padding_24 * 1.8,
        decoration: BoxDecoration(
          color: mainBlueColor.withOpacity(0.10),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_10,
          ),
        ),
        child: Image.asset(
          leading,
          color: color,
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

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_20,
    );
  }
}
