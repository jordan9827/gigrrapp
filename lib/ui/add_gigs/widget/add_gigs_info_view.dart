import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/add_gigs/add_gigs_view_model.dart';
import '../../../others/constants.dart';
import '../../../others/loading_button.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../../gigrr_type_drop_down_screen/gigrr_type_drop_down_view.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_price_criteria_view/price_criteria_view.dart';
import '../../widgets/cvm_text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/range_filter_view.dart';

class AddGigsInfoScreenView extends ViewModelWidget<AddGigsViewModel> {
  @override
  Widget build(BuildContext context, AddGigsViewModel viewModel) {
    return WillPopScope(
      onWillPop: () => Future.sync(viewModel.onWillPop),
      child: _buildFormView(viewModel),
    );
  }

  Widget _buildFormView(AddGigsViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          CVMTextFormField(
            title: "gig_name",
            controller: viewModel.gigrrNameController,
            hintForm: "i.e. Kirana Shop Delivery Boy",
          ),
          _buildBusinessTypeView(viewModel),
          GigrrTypeDropDownView(
            title: "gigrr_type",
            controller: viewModel.gigrrTypeController,
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
              bottom: SizeConfig.margin_padding_3,
              top: SizeConfig.margin_padding_8,
            ),
            child: Text(
              "select_multi_up_3".tr(),
              style: TSB.regularVSmall(
                textColor: textRegularColor,
              ),
            ),
          ),
          Text(
            "i_will_to_pay".tr(),
            style: TSB.semiBoldSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_8,
          ),
          _buildPriceCriteriaView(viewModel),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          PriceRangeFilterView(
            rangeValues: viewModel.currentRangeValues,
            onChanged: viewModel.setPayRange,
            rangeText: viewModel.payRangeText,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.navigationToNextPage,
            title: "next_add_operation".tr(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildBusinessTypeView(AddGigsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
          child: Text(
            "business_type".tr(),
            style: TSB.regularSmall(),
          ),
        ),
        CustomDropDownWidget(
          hintText: "i.e. Shopping Store",
          itemList:
              viewModel.businessesList.map((e) => e.businessName).toList(),
          visible: viewModel.isVisible,
          groupValue: viewModel.groupValue,
          onVisible: viewModel.onVisibleAction,
          selectSingleItemsAction: viewModel.onItemSelect,
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildPriceCriteriaView(AddGigsViewModel viewModel) {
    return PriceCriteriaView(
      title: false,
      controller: viewModel.priceTypeController,
    );
  }
}
