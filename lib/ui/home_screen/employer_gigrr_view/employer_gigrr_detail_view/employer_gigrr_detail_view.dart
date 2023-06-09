import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../data/network/dtos/candidate_gigs_request.dart';
import '../../../../data/network/dtos/gigrr_type_response.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../others/loading_button.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import 'employer_gigrr_detail_view_model.dart';

class EmployerGigrrDetailView extends StatelessWidget {
  final MyGigsData? gigs;
  final String gigsName;
  final String address;
  final String price;
  final List<GigrrTypeCategoryData> skillList;
  final bool isShortListed;
  const EmployerGigrrDetailView({
    Key? key,
    this.gigsName = "",
    this.isShortListed = false,
    this.price = "",
    this.address = "",
    required this.skillList,
    this.gigs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    MediaQueryData mediaQueryData = context.mediaQueryData;
    double outerPadding = SizeConfig.margin_padding_15;
    // var price1 =
    //     "₹ ${double.parse(data.fromAmount).toStringAsFixed(1)}-${double.parse(data.toAmount).toStringAsFixed(0)}/${data.priceCriteria}";
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => EmployerGigrrDetailViewModel(),
        builder: (context, viewModel, child) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildAppBarButtons(
                                    icon: grop_arrow_icon,
                                    onTap: () =>
                                        locator<NavigationService>().back(),
                                  ),
                                  _buildAppBarButtons(
                                    icon: grop_icon,
                                    onTap: () =>
                                        locator<NavigationService>().back(),
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
                            gigsName,
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
                            // mainAxisAlignment: MainAxisAlignment.start,
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
                                titleText: "Normal Price",
                              ),
                              _buildExPriceWidget(
                                outerPadding: outerPadding,
                                valueText: "1-3 Years",
                                titleText: "Required Experience",
                              ),
                            ],
                          ),
                          _buildSpacing(),
                          _buildOtherDetailView(
                            title: "Availibility",
                            infoList: [
                              "Weekends",
                              "Day Shift",
                              "Night Shift",
                            ],
                          ),
                          _buildSpacing(),
                          _buildOtherDetailView(
                            title: "Required Skill",
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
                if (isShortListed) ShortListView(gigs: gigs!),
              ],
            ),
          );
        });
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
            valueText,
            style: TSB.semiBoldSmall(
              textColor: mainBlueColor.withOpacity(0.90),
            ),
          ),
          _buildSpacing(
            height: SizeConfig.margin_padding_3,
          ),
          Text(
            titleText,
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
          title,
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

  Widget _buildAppBarButtons({
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(icon, scale: 2.8),
    );
  }
}

class ShortListView extends ViewModelWidget<EmployerGigrrDetailViewModel> {
  final MyGigsData gigs;
  ShortListView({required this.gigs});
  @override
  Widget build(BuildContext context, EmployerGigrrDetailViewModel viewModel) {
    var data = gigs.gigsRequestData.first;
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
                  id: gigs.id,
                  candidateId: data.candidate.id,
                ),
                title: "SHORTLIST GIGRR",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
