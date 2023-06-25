import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../others/constants.dart';
import '../../../others/loading_screen.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/text_styles.dart';
import 'payment_history_view_model.dart';
import 'widget/payment_widget.dart';

class PaymentHistoryScreenView extends StatelessWidget {
  const PaymentHistoryScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => PaymentHistoryViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "payment_history",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
          actions: [
            InkWell(
              onTap: () => viewModel.showFilterDialog(viewModel),
              child: Image.asset(ic_filter_wht, scale: 3.5),
            ),
          ],
        ),
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: RefreshIndicator(
            onRefresh: viewModel.refreshScreen,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.margin_padding_15,
                vertical: SizeConfig.margin_padding_10,
              ),
              child: ListView(
                children: viewModel.paymentList.map(
                  (e) {
                    return viewModel.paymentList.isEmpty
                        ? EmptyDataScreenView()
                        : PaymentHistoryWidget(data: e);
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Widget _buildPaymentList({required String title, int? count}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(
//         height: SizeConfig.margin_padding_15,
//       ),
//       Text(
//         title,
//         style: TSB.semiBoldMedium(textColor: independenceColor),
//       ),
//       ...List.generate(
//         count!,
//         (index) => PaymentHistoryWidget(),
//       )
//     ],
//   );
// }
}
