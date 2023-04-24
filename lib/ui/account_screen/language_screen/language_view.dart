import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'language_view_model.dart';

class LanguageScreenView extends StatefulWidget {
  const LanguageScreenView({Key? key}) : super(key: key);

  @override
  State<LanguageScreenView> createState() => _LanguageScreenViewState();
}

class _LanguageScreenViewState extends State<LanguageScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LanguageScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.initLocale(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "select_language",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: ListView(
          children: [_buildLanguageList(viewModel)],
        ),
      ),
    );
  }

  Widget _buildLanguageList(LanguageScreenViewModel viewModel) {
    return Container(
      margin: edgeInsetsMargin.copyWith(
        top: SizeConfig.margin_padding_29,
      ),
      child: Column(
        children: LanguageModel.languageList
            .map(
              (e) => _buildProfileListView(
                viewModel: viewModel,
                language: e,
                onChanged: (String? value) =>
                    viewModel.setLanguage(value!, context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildProfileListView({
    required LanguageScreenViewModel viewModel,
    required LanguageModel language,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.margin_padding_5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.margin_padding_10,
      ),
      decoration: BoxDecoration(
        color: mainGrayColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        // onTap: () => onChanged(language.id),
        minLeadingWidth: SizeConfig.margin_padding_10,
        contentPadding: EdgeInsets.zero,
        trailing: Radio<String>(
          activeColor: mainPinkColor,
          value: language.id,
          groupValue: viewModel.language,
          onChanged: (e) => onChanged(e),
        ),
        title: Text(
          language.name,
          style: TSB.regularMedium(),
        ),
      ),
    );
  }
}
