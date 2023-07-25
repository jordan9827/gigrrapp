import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/constants.dart';
import '../../../others/loading_screen.dart';
import 'terms_and_condition_viewmodel.dart';

class TermsAndConditionScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsAndConditionViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.getTermsAndCondition(),
      viewModelBuilder: () => TermsAndConditionViewModel(),
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: getAppBar(
            context,
            "terms_condition",
            showBack: true,
            onBackPressed: viewModel.navigatorToBack,
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: _buildWebView(viewModel),
          ),
        );
      },
    );
  }

  Widget _buildWebView(
    TermsAndConditionViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: edgeInsetsMargin,
      child: Html(
        style: {
          'p': Style(fontSize: FontSize.large),
        },
        data: viewModel.content,
        shrinkWrap: true,
      ),
    );
  }
}
