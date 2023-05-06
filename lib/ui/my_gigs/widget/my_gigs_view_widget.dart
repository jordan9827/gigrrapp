import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/network/dtos/my_gigs_response.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';

class MyGigsViewWidget extends StatelessWidget {
  final MyGigsResponseList myGigs;
  const MyGigsViewWidget({Key? key, required this.myGigs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: double.infinity,
      margin: edgeInsetsMargin.copyWith(top: SizeConfig.margin_padding_10),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.margin_padding_13),
        decoration: BoxDecoration(
          color: mainWhiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myGigs.gigName,
              style: TSB.semiBoldMedium(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ic_location, scale: 3),
                SizedBox(
                  width: SizeConfig.margin_padding_5,
                ),
                Expanded(
                  child: Text(
                    myGigs.gigAddress,
                    maxLines: 2,
                    style: TSB.regularSmall(textColor: textNoticeColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Text(
              "₹ ${myGigs.fromAmount.substring(0, 3)}/day",
              style: TSB.semiBoldLarge(textColor: independenceColor),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_8,
            ),
            Row(
              children: [
                _buildDurationView(
                  title: "${myGigs.duration} days",
                  subTitle: "job_duration",
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_10,
                ),
                _buildDurationView(
                  title: "${myGigs.gigsStartDate}",
                  subTitle: "start_date",
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            _buildDetailView()
          ],
        ),
      ),
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

  Widget _buildDetailView() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_15,
          vertical: SizeConfig.margin_padding_8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: mainPinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(SizeConfig.margin_padding_8),
        ),
        child: Text(
          "view".tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }
}
