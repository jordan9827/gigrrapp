import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../others/constants.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';
import 'intro_view_model.dart';

class IntroScreenView extends StatefulWidget {
  const IntroScreenView({Key? key}) : super(key: key);

  @override
  State<IntroScreenView> createState() => _IntroScreenViewState();
}

class _IntroScreenViewState extends State<IntroScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder<IntroScreenViewModel>.reactive(
      viewModelBuilder: () => IntroScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_40,
            ),
            SizedBox(
              height: SizeConfig.margin_padding_40,
              child: Image.asset(ic_gigrra_name),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Image.asset(ic_gigrra_logo),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            _buildTitleAndSubTitle(),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            _buildSkipButton(viewModel),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(IntroScreenViewModel viewModel) {
    return InkWell(
      onTap: viewModel.navigationToLoginView,
      child: Container(
        padding: EdgeInsets.all(10),
        width: SizeConfig.margin_padding_20 * 2.2,
        height: SizeConfig.margin_padding_20 * 2.2,
        decoration: BoxDecoration(
          color: mainPinkColor,
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_35,
          ),
        ),
        child: viewModel.isBusy
            ? Center(
                heightFactor: 10,
                child: SpinKitCircle(
                  size: SizeConfig.margin_padding_18,
                  color: mainWhiteColor,
                ),
              )
            : Image.asset(arrow_forword),
      ),
    );
  }

  Widget _buildTitleAndSubTitle() {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          'onBoardingTitle'.tr(),
          style: TSB.semiBoldLarge(),
        ),
        Text(
          'onBoardingSubTitle'.tr(),
          style: TSB.bold(
            textColor: independenceColor,
            textSize: SizeConfig.margin_padding_20 * 1.5,
          ),
        )
      ],
    );
  }
}
