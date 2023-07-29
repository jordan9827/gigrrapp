import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';

class MyGigsViewWidget extends StatelessWidget {
  final String title;
  final String address;
  final String price;
  final String jobDuration;
  final String startDate;
  final Widget bottomView;
  final bool isEmptyModel;
  const MyGigsViewWidget({
    Key? key,
    required this.bottomView,
    required this.title,
    required this.address,
    required this.price,
    this.isEmptyModel = true,
    required this.jobDuration,
    required this.startDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_10,
      ),
      padding: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.capitalize(),
            style: TSB.semiBoldMedium(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ic_location, scale: 2.8),
              SizedBox(
                width: SizeConfig.margin_padding_5,
              ),
              Expanded(
                child: Text(
                  address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TSB.regularSmall(textColor: textNoticeColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Text(
            price,
            style: TSB.semiBoldLarge(textColor: independenceColor),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Row(
            children: [
              _buildDurationView(
                title: jobDuration,
                subTitle: "job_duration",
              ),
              SizedBox(
                width: SizeConfig.margin_padding_10,
              ),
              _buildDurationView(
                title: startDate.toDateFormat(),
                subTitle: "start_date",
              ),
            ],
          ),
          if (isEmptyModel) _buildGiggsStatus()
        ],
      ),
    );
  }

  Widget _buildGiggsStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_10,
        ),
        Divider(),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        bottomView
      ],
    );
  }

  Widget _buildDurationView({
    required String title,
    required String subTitle,
  }) {
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
