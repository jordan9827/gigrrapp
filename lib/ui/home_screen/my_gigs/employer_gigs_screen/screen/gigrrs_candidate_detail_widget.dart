import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/network/dtos/my_gigs_response.dart';
import 'employer_gigs_detail_screen/employer_gigs_detail_view_model.dart';

class GigrrsCandidateWidget
    extends ViewModelWidget<EmployerGigsDetailViewModel> {
  final GigsRequestData data;
  final MyGigsData gigsData;

  const GigrrsCandidateWidget({
    required this.gigsData,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, EmployerGigsDetailViewModel viewModel) {
    SizeConfig.init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
        horizontal: SizeConfig.margin_padding_15,
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
          _buildTitleOfGiggrrs(data, viewModel),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
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
                "job_status".tr(),
                style: TSB.regularMedium(),
              ),
              if (data.status == "roster")
                _buildGigrsStatusView(text: "roster"),
              if (data.status == "start") _buildGigrsStatusView(text: "start"),
              if (data.status == "sent-offer")
                _buildGigrsStatusView(text: "sent_offer"),
              if (data.status == "received-offer")
                _buildGigrsSortListedView(viewModel)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGigrsStatusView({String text = ""}) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.margin_padding_5,
      ),
      child: Text(
        text.tr(),
        style: TSB.regularSmall(
          textColor: mainPinkColor,
        ),
      ),
    );
  }

  Widget _buildGigrsSortListedView(
    EmployerGigsDetailViewModel viewModel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "offer_accept_by_candidate".tr(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TSB.regularSmall(
              textColor: mainPinkColor,
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_8,
        ),
        _buildDetailView(
          onTap: () => viewModel.navigationToShortListedDetailView(
            gigs: gigsData,
            data: data,
          ),
        )
      ],
    );
  }

  Widget _buildDetailView({required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_17,
          vertical: SizeConfig.margin_padding_8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: mainPinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_8,
          ),
        ),
        child: Text(
          "shortList?".tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }

  Widget _buildTitleOfGiggrrs(
      GigsRequestData gigrr, EmployerGigsDetailViewModel viewModel) {
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
              gigrr.candidate.imageURL,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gigrr.employeeName,
                maxLines: 2,
                style: TSB.semiBoldLarge(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(ic_location, height: 25),
                  SizedBox(width: SizeConfig.margin_padding_3),
                  Expanded(
                    child: Text(
                      gigrr.candidate.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TSB.regularSmall(textColor: textNoticeColor),
                    ),
                  )
                ],
              )
            ],
          ),
        )
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
