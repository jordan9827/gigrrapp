import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrivacyPolicyViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.getPrivacyPolicy(),
      viewModelBuilder: () => PrivacyPolicyViewModel(),
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: getAppBar(
            context,
            "privacy_policy",
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

  Widget _buildWebView(PrivacyPolicyViewModel viewModel) {
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
