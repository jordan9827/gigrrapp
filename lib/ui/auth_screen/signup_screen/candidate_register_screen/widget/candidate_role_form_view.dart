import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../gigrr_type_drop_down_screen/gigrr_type_drop_down_view.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../candidate_register_view_model.dart';

class CandidateRoleFormView extends StatelessWidget {
  final CandidateRegisterViewModel viewModel;

  const CandidateRoleFormView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.loading,
      showDialogLoading: true,
      child: Scaffold(
        body: _buildFormView(context, viewModel),
      ),
    );
  }

  Widget _buildFormView(
      BuildContext context, CandidateRegisterViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
          GigrrTypeDropDownView(
            title: "I Can Be (*select multiple)",
            controller: viewModel.gigrrTypeController,
          ),
          _buildCostCriteriaView(viewModel),
          _buildRangeSliderView(viewModel),
          CVMTextFormField(
            title: "Total Experience",
            readOnly: true,
            hintForm: "i.e. 1 year",
            controller: viewModel.mobileController,
            suffixIcon: InkWell(
              onTap: () => _showExperiencePickerBottom(context),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: independenceColor,
              ),
            ),
          ),
          _buildCustomView(
            title: "i_am_avail",
            child: _buildMyAvailableView(),
          ),
          _buildCustomView(
            title: "select_shift",
            child: _buildSelectShiftView(),
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

  Widget _buildCustomView({String title = "", required Widget child}) {
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

  void _showExperiencePickerBottom(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _buildExperiencePickerView(),
    );
  }

  Widget _buildExperiencePickerView() {
    return Row(
      children: [
        Expanded(
            child: CupertinoPicker(
          itemExtent: 30,
          onSelectedItemChanged: (int value) {},
          children: List.generate(
            10,
            (index) => Text("${++index}"),
          ),
        ))
      ],
    );
  }

  Widget _buildRangeSliderView(CandidateRegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle("Select Cost"),
            Text(
              viewModel.payRangeText,
              style: TSB.regularVSmall(textColor: textRegularColor),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
            top: SizeConfig.margin_padding_3,
          ),
          child: SliderTheme(
            data: SliderThemeData(
              rangeTickMarkShape: const RoundRangeSliderTickMarkShape(
                tickMarkRadius: 0,
              ),
              valueIndicatorColor: Colors.pink,
              overlayShape: SliderComponentShape.noThumb,
            ),
            child: RangeSlider(
              activeColor: mainPinkColor,
              inactiveColor: mainGrayColor,
              values: viewModel.currentRangeValues,
              min: 0,
              max: 1000,
              divisions: 10,
              labels: RangeLabels(
                viewModel.currentRangeValues.start.round().toString(),
                viewModel.currentRangeValues.end.round().toString(),
              ),
              onChanged: viewModel.setPayRange,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_10,
        ),
      ],
    );
  }

  Widget _buildCostCriteriaView(CandidateRegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Cost Criteria"),
        CustomDropDownWidget(
          hintText: "i.e. hourly",
          itemList: viewModel.costCriteriaList,
          visible: viewModel.isVisible,
          groupValue: viewModel.costCriteriaValue,
          onVisible: viewModel.onVisibleAction,
          selectSingleItemsAction: viewModel.onCostCriteriaSelect,
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

  Widget _buildSelectShiftView() {
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

  Widget _buildMyAvailableView() {
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
