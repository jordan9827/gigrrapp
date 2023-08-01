import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../../others/comman_util.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../gigrr_type_drop_down_screen/gigrr_type_drop_down_view.dart';
import '../../../../widgets/custom_price_criteria_view/price_criteria_view.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../../../../widgets/range_filter_view.dart';
import '../candidate_register_view_model.dart';

class CandidateRoleFormView
    extends ViewModelWidget<CandidateRegisterViewModel> {
  @override
  Widget build(BuildContext context, CandidateRegisterViewModel viewModel) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.mapBoxLoading,
      showDialogLoading: true,
      child: Scaffold(
        body: _buildFormView(context, viewModel),
      ),
    );
  }

  Widget _buildFormView(
    BuildContext context,
    CandidateRegisterViewModel viewModel,
  ) {
    return Container(
      margin: edgeInsetsMargin,
      child: ListView(
        children: [
          GigrrTypeDropDownView(
            title: "i_can_be_sel_multi",
            controller: viewModel.gigrrTypeController,
          ),
          SizedBox(
            height: SizeConfig.margin_padding_13,
          ),
          PriceCriteriaView(
            controller: viewModel.costCriteriaController,
          ),
          _buildRangeSliderView(viewModel),
          CVMTextFormField(
            title: "total_experience",
            readOnly: true,
            hintForm: "i.e. 1 year",
            controller: viewModel.userExperiencesController,
            suffixIcon: InkWell(
              onTap: () => showCupertinoBottom(
                context,
                _buildExperienceBottomSheet(viewModel),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: independenceColor,
              ),
            ),
          ),
          _buildCustomView(
            title: "i_am_avail",
            child: _buildMyAvailableView(viewModel),
          ),
          _buildCustomView(
            title: "select_shift",
            child: _buildSelectShiftView(viewModel),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_35,
          ),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.candidateCompleteProfileApiCall,
            title: "create_profile",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildCustomView({
    String title = "",
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
          ),
          child: Text(
            title.tr(),
            style: TSB.regularSmall(),
          ),
        ),
        child,
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildExperienceBottomSheet(
    CandidateRegisterViewModel viewModel,
  ) {
    return Row(
      children: <Widget>[
        _buildCupertinoPicker(
          itemCount: 30,
          zero: true,
          onSelectedItemChanged: viewModel.pickerExperienceYear,
        ),
        _buildCupertinoPicker(
          zero: true,
          itemCount: 12,
          onSelectedItemChanged: viewModel.pickerExperienceMonth,
        ),
      ],
    );
  }

  Widget _buildCupertinoPicker({
    required int itemCount,
    bool zero = false,
    required Function(int) onSelectedItemChanged,
  }) {
    return Expanded(
      child: CupertinoPicker(
        looping: true,
        itemExtent: SizeConfig.margin_padding_29,
        onSelectedItemChanged: onSelectedItemChanged,
        children: List<Widget>.generate(itemCount, (int index) {
          var value = zero ? index : ++index;
          return Center(
            child: Text(
              (value).toString(),
              style: TextStyle(color: independenceColor),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRangeSliderView(
    CandidateRegisterViewModel viewModel,
  ) {
    return PriceRangeFilterView(
      rangeValues: viewModel.currentRangeValues,
      onChanged: viewModel.setPayRange,
      rangeText: viewModel.payRangeText,
    );
  }

  Widget _buildSelectShiftView(
    CandidateRegisterViewModel viewModel,
  ) {
    return Row(
      children: viewModel.shiftList
          .map(
            (e) => Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_20,
              ),
              child: Row(
                children: [
                  Radio<String>(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    activeColor: mainPinkColor,
                    value: e,
                    groupValue: viewModel.initialShift,
                    onChanged: viewModel.setShift,
                  ),
                  Text(
                    e.tr(),
                    style: TSB.regularSmall(
                      textColor: viewModel.initialShift != e
                          ? textRegularColor
                          : mainBlackColor,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMyAvailableView(
    CandidateRegisterViewModel viewModel,
  ) {
    var _list = viewModel.myAvailableList;
    return Row(
      children: _list
          .map(
            (e) => Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_20,
              ),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (val) => viewModel.onAvailableItemSelect(
                      val ?? false,
                      _list.indexOf(e),
                    ),
                    value: viewModel.myAvailableSelectList.contains(e),
                    activeColor: mainPinkColor,
                    visualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                  Text(
                    e.tr(),
                    style: TSB.regularSmall(
                      textColor: viewModel.myAvailableSelectList.contains(e)
                          ? mainBlackColor
                          : textRegularColor,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
