import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/constants.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/size_config.dart';
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
      margin: edgeInsetsMargin.copyWith(
        top: SizeConfig.margin_padding_10,
        bottom: SizeConfig.margin_padding_10,
      ),
      child: viewModel.initialIndex == 0
          ? _buildAppliedGigsListView(viewModel)
          : _buildShortListView(viewModel),
    );
  }

  Widget _buildAppliedGigsListView(CandidateGigsViewModel viewModel) {
    var itemCount = viewModel.itemCount == 0 ? 0 : viewModel.itemCount + 1;
    return viewModel.appliedGigsList.isNotEmpty
        ? ListView.builder(
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
                  myGigs: gigs,
                  bottomView: SizedBox(),

                );
              }
            },
          )
        : EmptyDataScreenView();
  }

  Widget _buildShortListView(CandidateGigsViewModel viewModel) {
    var itemCount = viewModel.itemCount == 0 ? 0 : viewModel.itemCount + 1;
    return viewModel.shortListGigsList.isNotEmpty
        ? ListView.builder(
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
                return MyGigsViewWidget(
                  myGigs: gigs,
                  bottomView: SizedBox(),
                );
              }
            })
        : EmptyDataScreenView();
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
