import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/candidate_gigs_request.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import '../candidate_gigrrs_view_model.dart';

class CandidateGigrrDetailView extends StackedView<CandidateGigrrsViewModel> {
  final CandidateGigsRequestData data;
  const CandidateGigrrDetailView({Key? key, required this.data})
      : super(key: key);

  @override
  Widget builder(
      BuildContext context, CandidateGigrrsViewModel viewModel, Widget? child) {
    SizeConfig.init(context);
    MediaQueryData mediaQueryData = context.mediaQueryData;
    double outerPadding = SizeConfig.margin_padding_15;
    var price =
        "₹ ${double.parse(data.fromAmount).toStringAsFixed(1)}-${double.parse(data.toAmount).toStringAsFixed(0)}/${data.priceCriteria}";
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: mediaQueryData.size.height * 0.5,
                width: mediaQueryData.size.width,
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/home_slide_demo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: kToolbarHeight,
                        width: mediaQueryData.size.width,
                        padding: EdgeInsets.only(
                          right: outerPadding,
                          left: outerPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAppBarButtons(
                              icon: grop_arrow_icon,
                              onTap: viewModel.navigateBack,
                            ),
                            _buildAppBarButtons(
                              icon: grop_icon,
                              onTap: viewModel.navigateBack,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: mediaQueryData.size.width,
                padding: EdgeInsets.all(outerPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.gigName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: SizeConfig.textSizeXLarge,
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ic_location, height: 23),
                        SizedBox(width: SizeConfig.margin_padding_3),
                        Expanded(
                          child: Text(
                            data.gigAddress,
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
                          valueText: "1-3 Years",
                          titleText: "experience",
                        ),
                      ],
                    ),
                    _buildSpacing(),
                    _buildOtherDetailView(
                      title: "availability",
                      infoList: viewModel.listOfAvailability,
                    ),
                    _buildSpacing(),
                    _buildOtherDetailView(
                      title: "required_skill",
                      infoList:
                          data.skillsCategoryList.map((e) => e.name).toList(),
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
                      action: () => viewModel.acceptedGigsRequest(
                        data.id,
                        viewModel.gigsData.indexOf(data),
                        isBack: true,
                      ),
                      title: "apply_now",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        ),
        _buildSpacing(),
        Wrap(
          spacing: SizeConfig.margin_padding_5,
          runSpacing: SizeConfig.margin_padding_5,
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

  Widget _buildAppBarButtons({
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(icon, scale: 2.8),
    );
  }

  @override
  CandidateGigrrsViewModel viewModelBuilder(BuildContext context) =>
      CandidateGigrrsViewModel();
}
