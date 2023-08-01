import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../custom_drop_down.dart';
import 'price_criteria_view_model.dart';

class PriceCriteriaView extends StatelessWidget {
  final bool title;
  final TextEditingController controller;
  const PriceCriteriaView({
    Key? key,
    required this.controller,
    this.title = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PriceCriteriaViewModel(controller),
      builder: (_, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title) _buildTitle("cost_criteria"),
          CustomDropDownWidget(
            hintText: "i.e. hourly",
            itemList: viewModel.costCriteriaList,
            visible: viewModel.isVisible,
            groupValue: viewModel.controller.text,
            onVisible: viewModel.onVisibleAction,
            selectSingleItemsAction: viewModel.onCostCriteriaSelect,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_13,
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String val) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
      child: Text(
        val.tr(),
        style: TSB.regularSmall(),
      ),
    );
  }
}
