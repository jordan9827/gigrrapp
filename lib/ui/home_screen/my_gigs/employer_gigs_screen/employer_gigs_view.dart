import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../others/constants.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/empty_data_screen.dart';
import '../../../widgets/notification_icon.dart';
import '../widget/my_gigs_view_widget.dart';
import 'employer_gigs_view_model.dart';

class EmployerGigsView extends StatefulWidget {
  const EmployerGigsView({Key? key}) : super(key: key);

  @override
  State<EmployerGigsView> createState() => _EmployerGigsViewState();
}

class _EmployerGigsViewState extends State<EmployerGigsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchMyGigsList(),
      viewModelBuilder: () => EmployerGigsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: mainGrayColor,
          appBar: AppBar(
            backgroundColor: mainWhiteColor,
            elevation: 0,
            title: Text(
              "my_gigs".tr(),
              style: TSB.semiBoldMedium(textColor: independenceColor),
            ),
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: _buildMyGigsList(viewModel),
          ),
        );
      },
    );
  }

  Widget _buildMyGigsList(EmployerGigsViewModel viewModel) {
    return Container(
      child: ListView(
        children: [
          if (viewModel.myGigsList.isNotEmpty)
            Column(
              children: viewModel.myGigsList
                  .map(
                    (gigs) => MyGigsViewWidget(
                      myGigs: gigs,
                    ),
                  )
                  .toList(),
            ),
          if (viewModel.myGigsList.isEmpty) EmptyDataScreenView(),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          )
        ],
      ),
    );
  }
}
