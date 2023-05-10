import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import 'about_us_view_model.dart';

class AboutUsScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutUsViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.getAboutUs(),
      viewModelBuilder: () => AboutUsViewModel(),
      builder: (_, viewModel, child) {
        return Scaffold(
          appBar: getAppBar(
            context,
            "about",
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

  Widget _buildWebView(AboutUsViewModel viewModel) {
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
