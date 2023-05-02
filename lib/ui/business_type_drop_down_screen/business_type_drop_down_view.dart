import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/network/dtos/business_type_category.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/text_styles.dart';
import '../widgets/drop_down_widget.dart';
import 'business_type_drop_down_view_model.dart';

class BusinessTypeDropDownView extends StatelessWidget {
  BusinessTypeDropDownView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (v) async {
        await v.businessTypeCategoryApiCall();
      },
      viewModelBuilder: () => BusinessTypeDropDownViewModel(),
      builder: (context, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("business_type"),
          CustomDropDownWidget(
            isLoading: viewModel.isBusy,
            hintText: 'i.e. Shopping Store',
            initialValue: viewModel.selectedBusinessType,
            onChanged: (val) {
              viewModel.selectedBusinessType = val as BusinessTypeCategoryList;
            },
            items: viewModel.businessTypeList
                .map<DropdownMenuItem<BusinessTypeCategoryList>>(
                    (BusinessTypeCategoryList value) {
              return DropdownMenuItem<BusinessTypeCategoryList>(
                value: value,
                child: Container(
                  width: SizeConfig.margin_padding_50 * 5,
                  child: Text(
                    value.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TSB.regularSmall(),
                  ),
                ),
              );
            }).toList(),
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
