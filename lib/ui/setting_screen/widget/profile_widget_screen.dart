import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../setting_view_model.dart';

class ProfileWidgetScreen extends StatelessWidget {
  final SettingScreenViewModel viewModel;
  const ProfileWidgetScreen({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
                  _buildEditProfile(viewModel)
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

  Widget _buildEditProfile(SettingScreenViewModel viewModel) {
    return InkWell(
      onTap: viewModel.navigationToEditProfileScreen,
      child: Container(
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
    );
  }
}
