import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../data/network/dtos/payment_history_response.dart';
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
      builder: (context, viewModel, child) {
        Widget _buildPaymentItemView({
          required String title,
          required List<PaymentHistoryData> list,
        }) {
          if (list.isEmpty) {
            return EmptyDataScreenView(
              enableBackButton: true,
            );
          } else {
            return Padding(
              padding: edgeInsetsMargin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.margin_padding_10,
                  ),
                  Text(
                    title.tr(),
                    style: TSB.semiBoldSmall(
                      textColor: independenceColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.margin_padding_5,
                  ),
                  Column(
                    children: list
                        .map(
                          (e) => PaymentHistoryWidget(
                            data: e,
                            viewModel: viewModel,
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            );
          }
        }

        return Scaffold(
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
                child: viewModel.paymentList.isEmpty
                    ? EmptyDataScreenView(
                        enableBackButton: true,
                      )
                    : ListView(
                        children: [
                          if (viewModel.todayList.isNotEmpty)
                            _buildPaymentItemView(
                              title: "today",
                              list: viewModel.todayList,
                            ),
                          if (viewModel.weekList.isNotEmpty)
                            _buildPaymentItemView(
                              title: "week",
                              list: viewModel.weekList,
                            ),
                          if (viewModel.monthList.isNotEmpty)
                            _buildPaymentItemView(
                              title: "month",
                              list: viewModel.monthList,
                            ),
                          if (viewModel.yearList.isNotEmpty)
                            _buildPaymentItemView(
                              title: "year",
                              list: viewModel.yearList,
                            ),
                          SizedBox(
                            height: SizeConfig.margin_padding_20,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
