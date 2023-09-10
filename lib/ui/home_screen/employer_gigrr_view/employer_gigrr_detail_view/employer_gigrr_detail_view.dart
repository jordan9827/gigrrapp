import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/gigrr_type_response.dart';
import '../../../../others/loading_button.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/detail_app_bar.dart';
import 'employer_gigrr_detail_view_model.dart';

class EmployerGigrrDetailView extends StatelessWidget {
  final String price;
  final String imageURL;
  final String candidateName;
  final String experience;
  final int candidateId;
  final int gigsId;
  final String address;
  final String availability;
  final List<GigrrTypeCategoryData> skillList;
  final bool isShortListed;

  const EmployerGigrrDetailView({
    Key? key,
    this.isShortListed = false,
    this.price = "",
    this.candidateId = 0,
    this.gigsId = 0,
    this.candidateName = "",
    this.experience = "",
    this.availability = "",
    this.address = "",
    this.imageURL = "",
    required this.skillList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    MediaQueryData mediaQueryData = context.mediaQueryData;
    double outerPadding = SizeConfig.margin_padding_15;
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => EmployerGigrrDetailViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.listOfAvailability.add(
          availability,
        );
      },
      builder: (context, viewModel, child) {
        // var availability = gigsRequestData.availabilityResp;
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    height: mediaQueryData.size.height * 0.5,
                    width: mediaQueryData.size.width,
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: mediaQueryData.size.width,
                    padding: EdgeInsets.all(outerPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          candidateName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: SizeConfig.textSizeXLarge,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.margin_padding_3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(ic_location, height: 23),
                            SizedBox(
                              width: SizeConfig.margin_padding_3,
                            ),
                            Expanded(
                              child: Text(
                                address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TSB.regularSmall(
                                  textColor: textNoticeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildExPriceWidget(
                              outerPadding: outerPadding,
                              valueText: price,
                              titleText: "normal_price",
                            ),
                            _buildExPriceWidget(
                              outerPadding: outerPadding,
                              valueText: experience.isNotEmpty
                                  ? experience
                                  : "0 " + "years".tr(),
                              titleText: "experience",
                            ),
                          ],
                        ),
                        _buildSpacing(),
                        if (viewModel.listOfAvailability.isNotEmpty)
                          _buildOtherDetailView(
                            title: "availability",
                            infoList: viewModel.listOfAvailability,
                          ),
                        _buildSpacing(),
                        if (skillList.isNotEmpty)
                          _buildOtherDetailView(
                            title: "required_skill",
                            infoList: skillList.map((e) => e.name).toList(),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.margin_padding_50 * 1.8,
                  )
                ],
              ),
              Positioned(
                top: SizeConfig.margin_padding_24,
                child: DetailAppBar(),
              ),
              if (isShortListed)
                ShortListView(
                  gigsId: gigsId,
                  candidateId: candidateId,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpacing({
    double? height,
  }) {
    return SizedBox(
      height: height ?? SizeConfig.margin_padding_14,
    );
  }

  Widget _buildExPriceWidget({
    required double outerPadding,
    required String valueText,
    required String titleText,
  }) {
    double width = (SizeConfig.screenWidth - (outerPadding * 2.5)) * 0.5;
    double padding = SizeConfig.margin_padding_20 * 0.5;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: mainBlueColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_14,
        ),
      ),
      padding: EdgeInsets.all(
        padding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            valueText.tr(),
            style: TSB.semiBoldSmall(
              textColor: mainBlueColor.withOpacity(0.90),
            ),
          ),
          _buildSpacing(
            height: SizeConfig.margin_padding_3,
          ),
          Text(
            titleText.tr(),
            style: TSB.regularSmall(),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherDetailView({
    required String title,
    required List<String> infoList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title.tr(),
          style: TSB.regularSmall(
            textColor: mainBlackColor.withOpacity(0.9),
          ),
        ),
        _buildSpacing(),
        Wrap(
          spacing: SizeConfig.margin_padding_5,
          runSpacing: SizeConfig.margin_padding_8,
          children:
              infoList.map((e) => _buildOtherDetailViewInfo(text: e)).toList(),
        ),
      ],
    );
  }

  Widget _buildOtherDetailViewInfo({
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        right: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_17,
          ),
        ),
        padding: EdgeInsets.all(
          SizeConfig.margin_padding_8,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}

class ShortListView extends ViewModelWidget<EmployerGigrrDetailViewModel> {
  final int gigsId;
  final int candidateId;

  ShortListView({
    this.candidateId = 0,
    this.gigsId = 0,
  });

  @override
  Widget build(BuildContext context, EmployerGigrrDetailViewModel viewModel) {
    return Positioned(
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kToolbarHeight * 2,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  mainWhiteColor,
                  mainWhiteColor.withOpacity(0.75),
                  mainWhiteColor.withOpacity(0.50),
                  mainWhiteColor.withOpacity(0.25),
                  mainWhiteColor.withOpacity(0.0),
                ],
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            color: mainWhiteColor,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              bottom: SizeConfig.margin_padding_14,
            ),
            child: SizedBox(
              width: SizeConfig.screenWidth * 0.5,
              child: LoadingButton(
                loading: viewModel.isBusy,
                action: () => viewModel.navigatorToGiggrRequestView(
                  id: gigsId,
                  candidateId: candidateId,
                ),
                title: "shortlist_gigrr",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
