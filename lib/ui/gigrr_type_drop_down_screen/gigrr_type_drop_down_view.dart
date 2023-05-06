import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../util/others/text_styles.dart';
import '../../data/network/dtos/gigrr_type_response.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/drop_down_widget.dart';
import 'gigrr_type_drop_down_view_model.dart';

class GigrrTypeDropDownView extends StatelessWidget {
  TextEditingController controller;
  GigrrTypeDropDownView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (v) async {
        await v.setGigrrTypeList();
      },
      viewModelBuilder: () => GigrrTypeDropDownViewModel(controller),
      builder: (context, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("gigrr_type"),
          CustomDropDownWidget(
            hintText: "i.e. Civil Engineer, Superviser",
            itemList: viewModel.itemsList,
            visible: viewModel.isVisible,
            enableMultiSelected: true,
            onVisible: viewModel.onVisibleAction,
            removeItems: viewModel.remove,
            onMultiSelectedList: viewModel.selectedItemList,
            selectMultipleItemsAction: viewModel.onItemSelect,
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
