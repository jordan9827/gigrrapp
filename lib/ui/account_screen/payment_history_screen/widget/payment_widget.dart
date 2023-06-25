import 'package:flutter/material.dart';
import '../../../../data/network/dtos/payment_history_response.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final PaymentHistoryData data;
  PaymentHistoryWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.margin_padding_10,
        vertical: SizeConfig.margin_padding_8,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
        leading: CircleAvatar(
          backgroundImage: AssetImage(ic_edit_profile),
          radius: SizeConfig.margin_padding_18,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.employer.firstName,
              style: TSB.semiBoldLarge(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_3,
            ),
            Text(
              "₹ ${data.amount}",
              style: TSB.semiBoldMedium(textColor: Colors.green),
            ),
          ],
        ),
        subtitle: Text(
          data.status,
          style: TSB.regularSmall(textColor: textNoticeColor),
        ),
      ),
    );
  }
}
