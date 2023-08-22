import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import '../../../../data/network/dtos/payment_history_response.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../payment_history_view_model.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final PaymentHistoryData data;
  final PaymentHistoryViewModel viewModel;
  PaymentHistoryWidget({
    required this.data,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var user = locator<UserAuthResponseData>();
    var name =
        user.isEmployer ? data.candidate.firstName : data.employer.firstName;
    var profileImage =
        user.isEmployer ? data.candidate.imageUrl : data.employer.imageUrl;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.margin_padding_10,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_10,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
          radius: SizeConfig.margin_padding_18,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name.capitalize(),
              style: TSB.semiBoldLarge(),
            ),
            Text(
              "₹ ${data.amount.toPriceFormat(0)}",
              style: TSB.semiBoldMedium(
                textColor: Colors.green,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              viewModel.filterStatusForPayment(
                data.status,
              ),
              style: TSB.regularSmall(
                textColor: textNoticeColor,
              ),
            ),
            Text(
              data.createdAt.toDateFormat(),
              style: TSB.regularSmall(
                textColor: mainPinkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
