import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/ui/no_internet_screen/no_internet_view_model.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoInternetViewModel>.reactive(
      viewModelBuilder: () => NoInternetViewModel(),
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.margin_padding_40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: context.screenWidth * 0.5,
                        width: context.screenWidth * 0.4,
                        child: Image.asset(
                          ic_obj_no_internet,
                        ),
                      ),
                      _buildSpace(),
                      Text(
                        "msg_for_no_internet".tr(),
                        textAlign: TextAlign.center,
                        style: TSB
                            .regular(
                              textSize: SizeConfig.textSizeMedium,
                            )
                            .merge(
                              TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      ),
                      _buildSpace(),
                      LoadingButton(
                        title: "try_again".tr(),
                        loading: viewModel.isBusy,
                        action: viewModel.checkInterNetStatus,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      height: SizeConfig.margin_padding_17,
    );
  }
}
