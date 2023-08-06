import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../custom_drop_down.dart';
import 'state_city_wiget_view_model.dart';

class StateCityWidgetView extends StatelessWidget {
  final TextEditingController stateController;
  final TextEditingController cityController;
  const StateCityWidgetView({
    Key? key,
    required this.stateController,
    required this.cityController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StateCityWidgetViewModel(
        city: cityController,
        state: stateController,
      ),
      builder: (_, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("state"),
          CustomDropDownWidget(
            hintText: "i.e. Madhya Pradesh",
            itemList: viewModel.stateCityService.stateList
                .map((e) => e.name.toUpperCase())
                .toList(),
            visible: viewModel.isVisibleForState,
            groupValue: viewModel.stateController.text,
            onVisible: viewModel.onVisibleActionForState,
            selectSingleItemsAction: viewModel.onItemSelectForState,
          ),
          _buildSpacer(),
          _buildTitle("city"),
          CustomDropDownWidget(
            isLoading: viewModel.isBusy,
            hintText: "i.e. Indore",
            itemList: viewModel.stateCityService.cityList
                .map((e) => e.name.toUpperCase())
                .toList(),
            visible: viewModel.isVisibleForCity,
            groupValue: viewModel.cityController.text,
            onVisible: viewModel.onVisibleActionForCity,
            selectSingleItemsAction: viewModel.onItemSelectForCity,
          ),
          _buildSpacer(),
        ],
      ),
    );
  }

  Widget _buildSpacer() {
    return SizedBox(
      height: SizeConfig.margin_padding_13,
    );
  }

  Widget _buildTitle(String val) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_8,
      ),
      child: Text(
        val.tr(),
        style: TSB.regularSmall(),
      ),
    );
  }
}
