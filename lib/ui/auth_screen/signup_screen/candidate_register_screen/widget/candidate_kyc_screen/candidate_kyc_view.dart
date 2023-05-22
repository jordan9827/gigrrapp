import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../../others/common_app_bar.dart';
import '../../../../../../others/constants.dart';
import '../../../../../../others/loading_button.dart';
import '../../../../../../util/others/image_constants.dart';
import '../../../../../../util/others/text_styles.dart';
import '../../../../../widgets/cvm_text_form_field.dart';
import 'candidate_kyc_view_model.dart';

class CandidateKYCScreenView extends StatefulWidget {
  const CandidateKYCScreenView({Key? key}) : super(key: key);

  @override
  State<CandidateKYCScreenView> createState() => _CandidateKYCScreenViewState();
}

class _CandidateKYCScreenViewState extends State<CandidateKYCScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CandidateKYCViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "upload_kyc_document",
          actions: [
            Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_15,
              ),
              height: SizeConfig.margin_padding_15,
              width: SizeConfig.margin_padding_15,
              child: Image.asset(ic_close_whit),
            ),
          ],
        ),
        body: Container(
          padding: edgeInsetsMargin,
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              CVMTextFormField(
                title: "enter_aadhaar_no",
                hintForm: "1234 1234 1234",
              ),
              CVMTextFormField(
                title: "upload_front_pic_aadhaar",
                formWidget:
                    _buildPickImageView(title: "upload_front_pic_aadhaar"),
              ),
              CVMTextFormField(
                title: "upload_back_pic_aadhaar",
                formWidget:
                    _buildPickImageView(title: "upload_back_pic_aadhaar"),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              LoadingButton(
                action: () {},
                title: 'submit',
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickImageView({required String title}) {
    return Container(
      height: SizeConfig.margin_padding_50 * 3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainPinkColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_24,
            width: SizeConfig.margin_padding_24,
            child: Image.asset(upload_image),
          ),
          SizedBox(height: SizeConfig.margin_padding_10),
          Text(
            title.tr(),
            style: TSB.regularMedium(textColor: independenceColor),
          ),
          SizedBox(height: SizeConfig.margin_padding_5),
          Text(
            "Image should be clear".tr(),
            style: TSB.regularSmall(textColor: fieldsRegularColor),
          )
        ],
      ),
    );
  }
}
