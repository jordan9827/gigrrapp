import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../others/common_app_bar.dart';
import '../../../../others/loading_button.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';
import 'defualt_language_view_model.dart';

class SelectDefaultLanguageView extends StatelessWidget {
  const SelectDefaultLanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SelectDefaultLanguageViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: independenceColor,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                child: Image.asset(
                  ic_language1,
                  color: Colors.white,
                  scale: 5,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.margin_padding_15,
                ),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: mainWhiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _buildSpacer(
                      SizeConfig.margin_padding_35,
                    ),
                    Text(
                      "See Gigrr form the selected language and region pair",
                      textAlign: TextAlign.center,
                      style: TSB.regularMedium(),
                    ),
                    _buildSpacer(
                      SizeConfig.margin_padding_10,
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    _buildSpacer(
                      SizeConfig.margin_padding_24,
                    ),
                    Text(
                      "SUGGESTED",
                      textAlign: TextAlign.center,
                      style: TSB.semiBoldSmall(),
                    ),
                    _buildSpacer(
                      SizeConfig.margin_padding_35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: LanguageModel.list.map(
                        (e) {
                          var isSelect = e.code == viewModel.initialSelected;
                          return _buildLanguageContainer(
                            isSelect: isSelect,
                            image: e.image,
                            name: e.name,
                            onTap: () => viewModel.onChange(e.code),
                          );
                        },
                      ).toList(),
                    ),
                    Spacer(),
                    if (viewModel.initialSelected.isNotEmpty)
                      LoadingButton(
                        action: viewModel.setLanguage,
                        title: 'Save',
                      ),
                    _buildSpacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageContainer({
    String name = "",
    String image = "",
    bool isSelect = false,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: isSelect ? mainPinkColor : mainGrayColor,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: SizeConfig.margin_padding_50 * 2,
                height: SizeConfig.margin_padding_50 * 1.2,
                child: Image.asset(
                  image,
                ),
              ),
              _buildSpacer(
                SizeConfig.margin_padding_10,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TSB.regularMedium(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_20,
    );
  }
}
