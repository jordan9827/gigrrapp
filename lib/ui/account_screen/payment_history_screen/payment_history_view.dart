import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'payment_history_view_model.dart';
import 'widget/payment_widget.dart';

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
        backgroundColor: mainGrayColor,
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
          child: ListView(
            children: [
              _buildPaymentList(title: "Today", count: 3),
              _buildPaymentList(title: "Oct 16, 2021", count: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentList({required String title, int? count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          title,
          style: TSB.semiBoldMedium(textColor: independenceColor),
        ),
        ...List.generate(
          count!,
          (index) => PaymentHistoryWidget(),
        )
      ],
    );
  }
}
