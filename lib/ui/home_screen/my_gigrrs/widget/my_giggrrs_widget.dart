import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../screen/my_gigrrs_detail_view_model.dart';

class MyGigrrsWidget extends ViewModelWidget<MyGigrrsDetailViewModel> {
  final Widget statusView;
  const MyGigrrsWidget({
    required this.statusView,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, MyGigrrsDetailViewModel viewModel) {
    SizeConfig.init(context);
    var media = MediaQuery.of(context).size;
    var data = viewModel.gigrrsData;
    var sizeWithStatus =
        viewModel.isStatusSize ? media.height * 0.47 : media.height * 0.42;
    return Container(
      width: double.infinity,
      height: media.height * 0.47,
      margin: EdgeInsets.all(SizeConfig.margin_padding_15),
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
          _buildTitleOfGiggrrs(data, viewModel),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            children: [
              _buildDurationView(
                title: data.gigsStartDate.toDateFormat(),
                subTitle: "start_date",
              ),
              SizedBox(
                width: SizeConfig.margin_padding_10,
              ),
              _buildDurationView(
                title:
                    "₹ ${data.gigsRequestData.first.offerAmount.toPriceFormat(0)}",
                subTitle: "offer_price",
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
                "all_real_estate_sol".tr(),
                style: TSB.semiBoldLarge(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              _buildAddressView(data.gigAddress),
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              viewModel.isStatusSize ? statusView : SizedBox()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitleOfGiggrrs(
      MyGigrrsRosterData gigrr, MyGigrrsDetailViewModel viewModel) {
    var profile = gigrr.gigsRequestData.first.candidate.imageURL;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_29 * 2.2,
          width: SizeConfig.margin_padding_50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              SizeConfig.margin_padding_10,
            ),
            child: Image.network(
              profile,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gigrr.gigName,
              maxLines: 2,
              style: TSB.semiBoldLarge(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_4,
            ),
            _buildDistanceView(
                "${gigrr.gigsRequestData.first.distance} KM Away")
          ],
        )
      ],
    );
  }

  Widget _buildAddressView(String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ic_location, height: 25),
        SizedBox(width: SizeConfig.margin_padding_3),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TSB.regularSmall(
              textColor: textNoticeColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceView(String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ic_location, height: 25),
        SizedBox(width: SizeConfig.margin_padding_3),
        Text(
          value,
          style: TSB.regularSmall(
            textColor: textNoticeColor,
          ),
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
