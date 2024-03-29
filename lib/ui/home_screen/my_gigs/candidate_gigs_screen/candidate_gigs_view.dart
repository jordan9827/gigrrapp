import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/candidate_roster_gigs_response.dart';
import '../../../../data/network/dtos/gigs_accepted_response.dart';
import '../../../../others/comman_util.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/constants.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/notification_icon.dart';
import '../widget/my_gigs_view_widget.dart';
import 'candidate_gigs_view_model.dart';

class CandidateGigsView extends StatefulWidget {
  const CandidateGigsView({Key? key}) : super(key: key);

  @override
  State<CandidateGigsView> createState() => _CandidateGigsViewState();
}

class _CandidateGigsViewState extends State<CandidateGigsView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => CandidateGigsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "my_gigs",
            backgroundColor: mainWhiteColor,
            textColor: mainBlackColor,
            actions: [
              NotificationIcon(),
            ],
            bottom: selectGigTab(viewModel),
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: RefreshIndicator(
              color: independenceColor,
              onRefresh: viewModel.refreshScreen,
              child: _buildCandidateView(viewModel),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCandidateView(CandidateGigsViewModel viewModel) {
    return Container(
      margin: edgeInsetsMargin,
      child: viewModel.initialIndex == 0
          ? _buildAppliedGigsListView(viewModel)
          : _buildShortListView(viewModel),
    );
  }

  Widget _buildAppliedGigsListView(CandidateGigsViewModel viewModel) {
    var itemCount = viewModel.itemCount == 0 ? 0 : viewModel.itemCount + 1;
    return viewModel.appliedGigsList.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.margin_padding_10,
            ),
            controller: viewModel.scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == viewModel.itemCount && viewModel.loading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: showLoading(50),
                );
              } else if (index < viewModel.itemCount) {
                var gigs = viewModel.appliedGigsList[index];
                return MyGigsViewWidget(
                  title: gigs.gigName,
                  address: gigs.gigAddress,
                  price: viewModel.price(
                    from: gigs.fromAmount,
                    to: gigs.toAmount,
                    priceCriteria: gigs.priceCriteria,
                  ),
                  startDate: gigs.gigsStartDate,
                  jobDuration: "${gigs.duration}" + " days".tr(),
                  bottomView: _buildAppliedGigsStatusView(
                    viewModel: viewModel,
                    gigs: gigs,
                  ),
                );
              }
              return SizedBox();
            },
          )
        : EmptyDataScreenView();
  }

  Widget _buildAppliedGigsStatusView({
    required CandidateGigsViewModel viewModel,
    required GigsAcceptedData gigs,
  }) {
    var status = viewModel.getGigStatus(gigs.gigsRequestData);
    String business = gigs.businessData.businessName;
    var nameBusiness = business.isNotEmpty ? business : "Super Enterprise";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameBusiness.capitalize(),
              style: TSB.semiBoldLarge(
                textColor: independenceColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Text(
              status.tr(),
              style: TSB.regularSmall(
                textColor: mainPinkColor,
              ),
            ),
          ],
        ),
        if (viewModel.statusSlug == "sent-offer")
          _buildActionButton(
            buttonText: "accept_offer",
            onTap: () => viewModel.showAcceptOfferDialog(viewModel, gigs),
          )
      ],
    );
  }

  Widget _buildShortListView(CandidateGigsViewModel viewModel) {
    var itemCount = viewModel.itemCount == 0 ? 0 : viewModel.itemCount + 1;
    return viewModel.shortListGigsList.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.margin_padding_10,
            ),
            controller: viewModel.scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == viewModel.itemCount && viewModel.loading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: showLoading(50),
                );
              } else if (index < viewModel.itemCount) {
                var gigs = viewModel.shortListGigsList[index];
                var price =
                    "₹ ${gigs.gigsRequestData.first.offerAmount.toPriceFormat(0)}/${gigs.priceCriteria}";
                return MyGigsViewWidget(
                  isShortListed: true,
                  title: gigs.gigName,
                  address: gigs.gigAddress,
                  price: price,
                  startDate: gigs.gigsStartDate,
                  jobDuration: "${gigs.duration}" + " days".tr(),
                  bottomView: _buildShortListGigsStatusView(
                    gigs: gigs,
                    viewModel: viewModel,
                  ),
                );
              }
              return SizedBox();
            })
        : EmptyDataScreenView();
  }

  Widget _buildShortListGigsStatusView({
    required CandidateGigsViewModel viewModel,
    required CandidateRosterData gigs,
  }) {
    var status = viewModel.getGigStatus(gigs.gigsRequestData);
    var buttonText = viewModel.statusForShortList(gigs.gigsRequestData);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gigs.business.businessName.capitalize(),
              style: TSB.semiBoldLarge(
                textColor: independenceColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.margin_padding_10,
                    ),
                    color: mainGreenColor,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.check,
                    color: mainWhiteColor,
                    size: SizeConfig.margin_padding_10,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_5,
                ),
                Text(
                  status.tr(),
                  style: TSB.regularSmall(
                    textColor: mainGreenColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildActionButton(
          buttonText: buttonText.tr(),
          onTap: () =>
              viewModel.loadShortListUpdateJobStatusApi(gigs, viewModel),
        )
      ],
    );
  }

  Widget _buildActionButton({
    required Function() onTap,
    String buttonText = "",
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_17,
          vertical: SizeConfig.margin_padding_8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: mainPinkColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_8,
          ),
        ),
        child: Text(
          buttonText.tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }

  PreferredSize selectGigTab(CandidateGigsViewModel viewModel) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        SizeConfig.margin_padding_29 * 2.2,
      ),
      child: Container(
        height: 45,
        margin: EdgeInsets.all(SizeConfig.margin_padding_13),
        decoration: BoxDecoration(
          color: Color(0xff48466D).withOpacity(0.12),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        child: TabBar(
          padding: EdgeInsets.all(3),
          controller: _tabController,
          onTap: viewModel.setInitialIndex,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: mainWhiteColor,
          ),
          labelColor: independenceColor,
          unselectedLabelColor: textRegularColor,
          tabs: [
            Tab(
              text: "applied".tr(),
            ),
            Tab(
              text: "short_list".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
