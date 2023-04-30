import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

import '../../../../../data/network/dtos/business_type_category.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/text_styles.dart';
import '../employes_register_view_model.dart';

class BusinessTypeDropDownWidget extends StatelessWidget {
  final EmployerRegisterViewModel viewModel;
  const BusinessTypeDropDownWidget({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("business_type"),
        DropdownButtonFormField(
          value: viewModel.selectedBusinessType,
          menuMaxHeight: SizeConfig.margin_padding_50 * 5,
          icon: SizedBox(),
          decoration: InputDecoration(
            counterText: '',
            labelStyle: const TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.all(10),
            hintText: 'i.e. Shopping Store',
            fillColor: mainGrayColor,
            suffixIcon: Container(
              width: SizeConfig.margin_padding_20,
              height: SizeConfig.margin_padding_20,
              padding: EdgeInsets.all(SizeConfig.margin_padding_15),
              child: Image.asset(
                'assets/images/arrow-drop_down.png',
              ),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: textRegularColor,
            ),
            errorBorder: inputBorder,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
          ),
          onChanged: (val) {
            viewModel.selectedBusinessType = val;
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
