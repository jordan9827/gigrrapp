import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/comman_util.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/text_styles.dart';
import 'rating_review_view_model.dart';

class RatingReviewScreenView extends StatelessWidget {
  final String name;
  final String gigsId;
  final String candidateId;
  final String profile;
  const RatingReviewScreenView({
    Key? key,
    this.name = "",
    this.gigsId = "",
    this.profile = "",
    this.candidateId = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RatingReviewViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "rating",
          showBack: true,
          onBackPressed: viewModel.navigatorToBack,
        ),
        body: ListView(
          padding: EdgeInsets.all(
            SizeConfig.margin_padding_20,
          ),
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_10,
            ),
            Text(
              textAlign: TextAlign.center,
              "how_was_the_gigrr".tr(),
              style: TSB.boldHeading(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profile),
              radius: SizeConfig.margin_padding_18 * 2.5,
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Text(
              textAlign: TextAlign.center,
              name,
              style: TSB.boldLarge(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Text(
              textAlign: TextAlign.center,
              "tap_to_rate_gigrr".tr(),
              style: TSB.semiBoldLarge(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_10,
            ),
            Align(
              alignment: Alignment.center,
              child: RatingBar(
                minRating: 1,
                itemCount: 5,
                allowHalfRating: true,
                updateOnDrag: true,
                initialRating: viewModel.initialRating,
                itemSize: 30,
                ratingWidget: RatingWidget(
                  full: Image.asset(ic_select_rating),
                  half: Image.asset(ic_select_rating),
                  empty: Image.asset(ic_unselect_rating),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: viewModel.onRatingUpdate,
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            _buildCommentView(viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildCommentView(RatingReviewViewModel viewModel) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          "share_your_experince".tr(),
          style: TSB.regularSmall(
            textColor: textRegularColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        TextFormField(
          maxLines: 4,
          controller: viewModel.commentController,
          style: TextStyle(color: mainBlackColor),
          decoration: InputDecoration(
            hintText: "type_review".tr(),
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: inputBorder,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        LoadingButton(
          loading: viewModel.isBusy,
          action: () => viewModel.ratingReviewSubmit(
            id: gigsId,
            candidateId: candidateId,
          ),
          title: "give_rating",
        )
      ],
    );
  }
}
