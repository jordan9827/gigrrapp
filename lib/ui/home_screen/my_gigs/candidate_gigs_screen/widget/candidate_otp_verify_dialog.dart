import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:square_demo_architecture/others/constants.dart';
import '../../../../../data/network/dtos/candidate_roster_gigs_response.dart';
import '../../../../../others/loading_button.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/pin_code_field.dart';
import '../candidate_gigs_view_model.dart';

class CandidateJobOTPVerifyDialog extends StatelessWidget {
  final CandidateGigsViewModel viewModel;
  final CandidateRosterData gigs;
  final String title;
  final String status;

  const CandidateJobOTPVerifyDialog({
    Key? key,
    this.title = "",
    this.status = "",
    required this.viewModel,
    required this.gigs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_20,
          vertical: SizeConfig.margin_padding_15,
        ),
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            _buildSpacer(
              size: SizeConfig.margin_padding_10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.margin_padding_15,
              ),
              child: Image.asset(ic_congratutation),
            ),
            _buildSpacer(),
            Text(
              textAlign: TextAlign.center,
              gigs.business.businessName.capitalize(),
              style: TSB.semiBoldHeading(),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_5,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TSB.regularMedium(),
            ),
            _buildSpacer(),
            CVPinCodeTextField(
              controller: viewModel.otpController,
              onChanged: (value) {},
            ),
            _buildSpacer(),
            Row(
              children: [
                Expanded(
                  child: LoadingButton(
                    backgroundColor: mainGrayColor,
                    titleColor: mainBlackColor,
                    title: "cancel",
                    action: () {
                      viewModel.navigationService.back();
                      viewModel.otpController.clear();
                    },
                  ),
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_15,
                ),
                Expanded(
                  child: LoadingButton(
                    loading: viewModel.isBusy,
                    title: "submit",
                    action: () => viewModel.loadGigsVerifyOTP(
                      id: gigs.id,
                      status: status,
                    ),
                  ),
                ),
              ],
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacer({double? size}) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_24,
    );
  }
}
