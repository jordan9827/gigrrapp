import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/toggle_app_bar_widget.dart';
import 'widget/employer_business_form_view.dart';
import 'employer_register_view_model.dart';
import 'widget/employer_personal_form_view.dart';

class EmployerRegisterScreenView extends StatelessWidget {
  final bool isSocialLogin;
  final String phoneNumber;
  const EmployerRegisterScreenView({
    Key? key,
    this.phoneNumber = "",
    this.isSocialLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerRegisterViewModel(
        mobile: phoneNumber,
        isSocial: isSocialLogin,
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
                    EmployerPersonalInfoFormView(),
                    EmployerBusinessInfoFormView()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(EmployerRegisterViewModel viewModel) {
    var isCheckIndex = viewModel.pageIndex == 0 ? true : false;
    return ToggleAppBarWidgetView(
      appBarTitle: "create_your_profile",
      firstTitle: "personal_info",
      secondTitle: "business_info",
      isCheck: isCheckIndex,
      backAction: viewModel.navigatorToBack,
      showBack: true,
    );
  }
}
