import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/network/dtos/business_type_category.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/text_styles.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/drop_down_widget.dart';
import 'business_type_drop_down_view_model.dart';

class BusinessTypeDropDownView extends StatelessWidget {
  final TextEditingController controller;
  BusinessTypeDropDownView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (v) async {
        await v.setBusinessTypeList();
      },
      viewModelBuilder: () => BusinessTypeDropDownViewModel(controller),
      builder: (context, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("business_type"),
          CustomDropDownWidget(
            hintText: "i.e. Shopping Store",
            itemList: viewModel.itemsList,
            visible: viewModel.isVisible,
            groupValue: viewModel.groupValue,
            onVisible: viewModel.onVisibleAction,
            selectSingleItemsAction: viewModel.onItemSelect,
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
