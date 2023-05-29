import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view_model.dart';

import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';

class ProfileWidgetScreen extends StatelessWidget {
  final AccountViewModel viewModel;

  const ProfileWidgetScreen({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var isEmployer = viewModel.user.isEmployer;
    Color textColor = isEmployer ? independenceColor : mainWhiteColor;
    Color textColor1 =
        isEmployer ? textRegularColor : mainWhiteColor.withOpacity(0.70);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(SizeConfig.margin_padding_15),
          width: MediaQuery.of(context).size.width,
          color:
              isEmployer ? mainPinkColor.withOpacity(0.10) : independenceColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.user.fullName,
                    style: TSB.boldXLarge(textColor: textColor),
                  ),
                  _buildEditProfile(
                    viewModel: viewModel,
                    isEmployer: isEmployer,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.margin_padding_3,
              ),
              Text(
                viewModel.user.phoneNumber,
                style: TSB.semiBoldSmall(textColor: textColor),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    ic_location,
                    color: textColor1,
                    height: SizeConfig.margin_padding_20,
                  ),
                  SizedBox(
                    width: SizeConfig.margin_padding_3,
                  ),
                  Expanded(
                    child: Text(
                      viewModel.user.address,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TSB.regularVSmall(
                        textColor: textColor1,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 1,
        ),
        if (isEmployer) _buildBusinessView(viewModel),
        if (!isEmployer) _buildGigPreferencesView(viewModel)
      ],
    );
  }

  Widget _buildBusinessView(AccountViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.margin_padding_10),
      width: double.infinity,
      color: mainPinkColor.withOpacity(0.10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "your_businesses".tr(),
            style: TSB.regularMedium(),
          ),
          InkWell(
            onTap: viewModel.navigationToBusinessesScreen,
            child: Image.asset(
              ic_pink_arrow_forword,
              height: SizeConfig.margin_padding_15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGigPreferencesView(AccountViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.margin_padding_10),
      width: double.infinity,
      color: independenceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "gig_preference".tr(),
            style: TSB.regularMedium(textColor: mainWhiteColor),
          ),
          InkWell(
            onTap: viewModel.navigationToCandidatePreferencesScreen,
            child: Image.asset(
              ic_pink_arrow_forword,
              color: mainWhiteColor,
              height: SizeConfig.margin_padding_15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditProfile({
    required AccountViewModel viewModel,
    bool isEmployer = false,
  }) {
    Color textColor = isEmployer ? mainPinkColor : mainWhiteColor;
    return InkWell(
      onTap: viewModel.navigationToEditProfileScreen,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_10,
          vertical: SizeConfig.margin_padding_5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: textColor),
        ),
        child: Text(
          "txt_edit".tr(),
          style: TSB.regularVSmall(textColor: textColor),
        ),
      ),
    );
  }
}
