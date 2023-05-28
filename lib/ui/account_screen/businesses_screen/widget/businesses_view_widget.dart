import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/account_screen/businesses_screen/businesses_view_model.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/text_styles.dart';

class BusinessesViewWidget extends StatelessWidget {
  final BusinessesViewModel viewModel;
  final GetBusinessesData businesses;

  const BusinessesViewWidget({
    Key? key,
    required this.businesses,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: double.infinity,
      margin: edgeInsetsMargin.copyWith(top: SizeConfig.margin_padding_10),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.margin_padding_17),
        decoration: BoxDecoration(
          color: mainWhiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              businesses.categoryResp.name,
              style: TSB.semiBoldSmall(textColor: mainBlueColor),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_3,
            ),
            Text(
              businesses.businessName,
              style: TSB.boldMedium(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ic_location, scale: 3),
                SizedBox(
                  width: SizeConfig.margin_padding_5,
                ),
                Expanded(
                  child: Text(
                    businesses.businessAddress,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TSB.regularSmall(textColor: textNoticeColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildShopImage(),
                _buildEditView(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShopImage() {
    return Row(
      children: businesses.businessesImage
          .map(
            (e) => Container(
              height: SizeConfig.margin_padding_40 * 1.9,
              width: SizeConfig.margin_padding_50 * 1.1,
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_8,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  SizeConfig.margin_padding_10,
                ),
                child: Image.network(
                  e.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEditView() {
    return InkWell(
      onTap: () => viewModel.navigatorToEditBusinessesView(businesses),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_18,
          vertical: SizeConfig.margin_padding_8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: mainPinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(SizeConfig.margin_padding_8),
        ),
        child: Text(
          "txt_edit".tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }
}
