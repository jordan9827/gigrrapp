import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
import '../screen/my_gigrrs_detail_view_model.dart';

class MyGigrrsWidget extends ViewModelWidget<MyGigrrsDetailViewModel> {
  final GigsRequestData data;
  final Widget statusView;

  const MyGigrrsWidget({
    required this.data,
    required this.statusView,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, MyGigrrsDetailViewModel viewModel) {
    SizeConfig.init(context);
    var media = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: media.height * 0.47,
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleOfGiggrrs(data, viewModel),
          _buildSpacer(),
          Row(
            children: [
              _buildDurationView(
                title: data.createdAt.toDateFormat(),
                subTitle: "start_date",
              ),
              SizedBox(
                width: SizeConfig.margin_padding_10,
              ),
              _buildDurationView(
                title: "₹ ${data.offerAmount.toPriceFormat(0)}",
                subTitle: "offer_price",
              ),
            ],
          ),
          _buildSpacer(
            SizeConfig.margin_padding_10,
          ),
          Divider(
            thickness: 1,
            color: mainGrayColor,
          ),
          _buildSpacer(
            SizeConfig.margin_padding_5,
          ),
          Text(
            "all_real_estate_sol".tr(),
            style: TSB.semiBoldLarge(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_5,
          ),
          _buildAddressView(
            data: data,
            viewModel: viewModel,
          ),
          _buildSpacer(),
          statusView
        ],
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_15,
    );
  }

  Widget _buildTitleOfGiggrrs(
    GigsRequestData gigrr,
    MyGigrrsDetailViewModel viewModel,
  ) {
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
              data.candidate.imageURL,
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
              data.employeeName,
              maxLines: 2,
              style: TSB.semiBoldLarge(),
            ),
            _buildSpacer(
              SizeConfig.margin_padding_4,
            ),
            _buildDistanceView("${data.distance} " + "km_away".tr())
          ],
        )
      ],
    );
  }

  Widget _buildAddressView({
    required GigsRequestData data,
    required MyGigrrsDetailViewModel viewModel,
  }) {
    return InkWell(
      onTap: () => viewModel.navigationToGoogleMap(
        lat: data.candidate.latitude,
        lng: data.candidate.longitude,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ic_location,
            height: 25,
          ),
          SizedBox(
            width: SizeConfig.margin_padding_3,
          ),
          Expanded(
            child: Text(
              data.candidate.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TSB.regularSmall(
                textColor: textNoticeColor,
              ),
            ),
          ),
        ],
      ),
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
            _buildSpacer(
              SizeConfig.margin_padding_3,
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
