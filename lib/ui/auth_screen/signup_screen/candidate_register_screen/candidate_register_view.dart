import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/toggle_app_bar_widget.dart';
import 'widget/candidate_role_form_view.dart';
import 'candidate_register_view_model.dart';
import 'widget/candidate_personal_form_view.dart';

class CandidateRegisterScreenView extends StatelessWidget {
  final String phoneNumber;

  const CandidateRegisterScreenView({Key? key, this.phoneNumber = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) async {
        await viewModel.businessTypeService.businessRepo.gigrrTypeCategory();
      },
      viewModelBuilder: () => CandidateRegisterViewModel(
        mobile: phoneNumber,
        isMobileRead: phoneNumber.isNotEmpty,
      ),
      builder: (_, viewModel, child) => WillPopScope(
        onWillPop: () => Future.sync(viewModel.onWillPop),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(viewModel),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: viewModel.setPageIndex,
                  controller: viewModel.controller,
                  children: [
                    // CandidatePersonalInfoFormView(
                    //   viewModel: viewModel,
                    // ),
                    CandidateRoleFormView(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(CandidateRegisterViewModel viewModel) {
    var isCheckIndex = viewModel.pageIndex == 0 ? true : false;
    return ToggleAppBarWidgetView(
      appBarTitle: "create_your_profile",
      firstTitle: "personal_info",
      secondTitle: "role_availability",
      isCheck: isCheckIndex,
    );
  }
}
