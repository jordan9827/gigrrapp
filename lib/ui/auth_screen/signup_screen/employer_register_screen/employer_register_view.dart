import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/toggle_app_bar_widget.dart';
import 'employer_business_form_view.dart';
import 'employer_personal_form_view.dart';
import 'employer_register_view_model.dart';

class EmployerRegisterScreenView extends StatefulWidget {
  const EmployerRegisterScreenView({Key? key}) : super(key: key);

  @override
  State<EmployerRegisterScreenView> createState() =>
      _EmployerRegisterScreenViewState();
}

class _EmployerRegisterScreenViewState
    extends State<EmployerRegisterScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerRegisterViewModel(),
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
                    EmployerPersonalInfoFormView(
                      viewModel: viewModel,
                    ),
                    EmployerBusinessInfoFormView(
                      viewModel: viewModel,
                    )
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
