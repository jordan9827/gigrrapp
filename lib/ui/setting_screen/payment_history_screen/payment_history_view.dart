import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'payment_history_view_model.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PaymentHistoryViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "payment_history",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
          actions: [
            Image.asset(ic_filter_wht, scale: 3.5),
          ],
        ),
        body: Container(
          margin: edgeInsetsMargin,
          child: _buildPaymentList(),
        ),
      ),
    );
  }

  Widget _buildPaymentList() {
    return ListView(
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          "Today",
          style: TSB.semiBoldMedium(textColor: independenceColor),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          physics: PageScrollPhysics(),
          itemBuilder: (context, i) => Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.margin_padding_5),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.margin_padding_10,
              vertical: SizeConfig.margin_padding_8,
            ),
            decoration: BoxDecoration(
              color: mainWhiteColor,
              borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              // contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
              leading: CircleAvatar(
                backgroundImage: AssetImage(ic_edit_profile),
                radius: SizeConfig.margin_padding_18,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suresh Kumar",
                    style: TSB.semiBoldMedium(),
                  ),
                  Text(
                    "Successfully Paid",
                    style: TSB.regularSmall(textColor: textNoticeColor),
                  ),
                ],
              ),
              trailing: Container(
                margin: EdgeInsets.all(SizeConfig.margin_padding_8),
                constraints: const BoxConstraints(minWidth: 70.0, maxWidth: 80),
                height: double.infinity,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "₹ 400",
                    style: TSB.semiBoldMedium(textColor: Colors.green),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
