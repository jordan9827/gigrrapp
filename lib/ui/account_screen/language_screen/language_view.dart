import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'language_view_model.dart';

class LanguageScreenView extends StatelessWidget {
  const LanguageScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
        body: Container(
          margin: EdgeInsets.all(
            SizeConfig.margin_padding_15,
          ),
          child: Column(
            children: [
              _buildLanguageList(context, viewModel),
              Spacer(),
              LoadingButton(
                action: () => viewModel.save(context),
                title: "save",
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageList(
    BuildContext context,
    LanguageScreenViewModel viewModel,
  ) {
    return Column(
      children: LanguageModel.languageList
          .map(
            (e) => _buildProfileListView(
              viewModel: viewModel,
              language: e,
              onChanged: viewModel.setLanguage,
            ),
          )
          .toList(),
    );
  }

  Widget _buildProfileListView({
    required LanguageScreenViewModel viewModel,
    required LanguageModel language,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.margin_padding_10,
      ),
      decoration: BoxDecoration(
        color: mainGrayColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
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
