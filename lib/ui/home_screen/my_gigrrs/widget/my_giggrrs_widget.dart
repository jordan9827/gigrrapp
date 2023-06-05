import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';

class MyGiggrrsWidget extends StatelessWidget {
  const MyGiggrrsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_10,
      ),
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleOfGiggrrs(),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            children: [
              _buildDurationView(
                title: "${5} days",
                subTitle: "job_duration",
              ),
              SizedBox(
                width: SizeConfig.margin_padding_10,
              ),
              _buildDurationView(
                title: "5",
                subTitle: "start_date",
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Divider(
            thickness: 1,
            color: mainGrayColor,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Real Estate Solution",
                style: TSB.semiBoldLarge(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              _buildLocationView("25, Pardeshipura, Near Shiv Mandir, Indore")
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitleOfGiggrrs() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: SizeConfig.margin_padding_29 * 2.2,
          width: SizeConfig.margin_padding_50,
          decoration: BoxDecoration(
            color: mainGrayColor,
            borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Suresh Kumar",
              maxLines: 2,
              style: TSB.semiBoldLarge(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_4,
            ),
            _buildLocationView("4 KM Away")
          ],
        )
      ],
    );
  }

  Widget _buildLocationView(String location) {
    return Row(
      children: [
        Image.asset(ic_location, height: 25),
        SizedBox(width: SizeConfig.margin_padding_3),
        Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TSB.regularSmall(textColor: textNoticeColor),
        ),
      ],
    );
  }

  Widget _buildDurationView({required String title, required String subTitle}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(
          SizeConfig.margin_padding_10,
        ),
        decoration: BoxDecoration(
          color: mainBlueColor.withOpacity(0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.tr(),
              style: TSB.semiBoldSmall(textColor: mainBlueColor),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_3,
            ),
            Text(
              subTitle.tr(),
              style: TSB.regularSmall(),
            ),
          ],
        ),
      ),
    );
  }
}
