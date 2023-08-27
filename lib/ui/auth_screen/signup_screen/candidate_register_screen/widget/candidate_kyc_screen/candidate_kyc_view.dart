import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../../others/common_app_bar.dart';
import '../../../../../../others/constants.dart';
import '../../../../../../others/loading_button.dart';
import '../../../../../../others/loading_screen.dart';
import '../../../../../../util/others/image_constants.dart';
import '../../../../../../util/others/text_styles.dart';
import '../../../../../widgets/cvm_text_form_field.dart';
import 'candidate_kyc_view_model.dart';

class CandidateKYCScreenView extends StatelessWidget {
  final bool isSocial;
  final String socialId;
  final String socialType;
  const CandidateKYCScreenView({
    Key? key,
    this.socialId = "",
    this.socialType = "",
    this.isSocial = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CandidateKYCViewModel(
        social: isSocial,
        socialType: socialType,
        socialId: socialId,
      ),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "upload_kyc_document",
          actions: [
            InkWell(
              onTap: () => viewModel.verifyOTPForSocialLogin(
                viewModel.user,
              ),
              child: Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.margin_padding_15,
                ),
                height: SizeConfig.margin_padding_15,
                width: SizeConfig.margin_padding_15,
                child: Image.asset(ic_close_whit),
              ),
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
                maxLength: 12,
                title: "enter_aadhaar_no",
                hintForm: "i.e. 1234 1234 1234",
                controller: viewModel.aadhaarController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              _buildPickedImageWidget(
                context,
                viewModel: viewModel,
                title: "upload_front_pic_aadhaar",
                subTitle: "upload_front_pic_aadhaar",
                image: viewModel.frontAadhaarImage,
              ),
              _buildPickedImageWidget(
                context,
                viewModel: viewModel,
                title: "upload_back_pic_aadhaar",
                subTitle: "upload_back_pic_aadhaar",
                image: viewModel.backAadhaarImage,
                isFont: false,
              ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
              LoadingButton(
                loading: viewModel.isBusy,
                action: viewModel.candidateKYCApi,
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

  Widget _buildPickedImageWidget(
    BuildContext context, {
    required String title,
    required String subTitle,
    required String image,
    bool isFont = true,
    required CandidateKYCViewModel viewModel,
  }) {
    return CVMTextFormField(
      title: title,
      formWidget: image.isNotEmpty
          ? _buildImageView(image: image, viewModel: viewModel, isFont: isFont)
          : _buildImagePickerView(
              title: subTitle,
              onPick: () => viewModel.pickImage(context, isFontImage: isFont),
            ),
    );
  }

  Widget _buildImageView({
    required String image,
    bool isFont = true,
    required CandidateKYCViewModel viewModel,
  }) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.margin_padding_50 * 3,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              SizeConfig.margin_padding_10,
            ),
            child: Image.network(
              image,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () => viewModel.deleteImageApi(
                imagePath: image,
                pickImage: isFont,
              ),
              child: Container(
                width: SizeConfig.margin_padding_24,
                height: SizeConfig.margin_padding_24,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                    SizeConfig.margin_padding_20,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(ic_remove_wht),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerView({
    required String title,
    required Function() onPick,
  }) {
    return InkWell(
      onTap: onPick,
      child: Container(
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
      ),
    );
  }
}
