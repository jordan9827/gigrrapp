import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import '../../../../others/comman_util.dart';
import '../../../../others/loading_button.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/custom_date_picker.dart';
import 'candidate_preferences_view_model.dart';
import 'preference_custom_ui_widget.dart';

class CandidatePreferenceScreenView extends StatelessWidget {
  const CandidatePreferenceScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.initState(),
      viewModelBuilder: () => CandidatePreferenceViewModel(),
      builder: (_, viewModel, child) => LoadingScreen(
        loading: viewModel.loading,
        showDialogLoading: true,
        child: Scaffold(
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "gig_preference",
            textColor: mainBlackColor,
            backgroundColor: mainWhiteColor,
            actions: [
              InkWell(
                onTap: viewModel.navigationToBack,
                child: Container(
                  margin: EdgeInsets.only(
                    right: SizeConfig.margin_padding_15,
                  ),
                  height: SizeConfig.margin_padding_15,
                  width: SizeConfig.margin_padding_15,
                  child: Image.asset(
                    ic_close_blck,
                    color: mainBlackColor,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            padding: edgeInsetsMargin,
            child: ListView(
              children: [
                _buildLocationView(viewModel),
                _buildDistanceView(viewModel),
                _buildAvailabilityShiftView(viewModel),
                _buildPayRangeView(viewModel),
                _buildAvailabilityDateView(viewModel),
                _buildSkillsView(viewModel),
                _buildSpacer(),
                LoadingButton(
                  loading: viewModel.isBusy,
                  action: viewModel.loadAddPreference,
                  title: 'submit',
                ),
                _buildSpacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationView(CandidatePreferenceViewModel viewModel) {
    return PreferenceCustomUIWidget(
      title: 'location',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              viewModel.addressController.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TSB.regularVSmall(),
            ),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          InkWell(
            onTap: viewModel.mapBoxPlace,
            child: Container(
              padding: EdgeInsets.all(
                SizeConfig.margin_padding_8,
              ),
              decoration: BoxDecoration(
                color: mainBlueColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.my_location_outlined,
                color: mainPinkColor,
                size: 25,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDistanceView(
    CandidatePreferenceViewModel viewModel,
  ) {
    return PreferenceCustomUIWidget(
      title: 'distance',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "set_mix_distance".tr(),
                style: TSB.regularSmall(),
              ),
              Text(
                "txt_around_km".tr(args: ["${viewModel.maxDiscount}"]),
                style: TSB.regularVSmall(),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.margin_padding_8,
              top: SizeConfig.margin_padding_13,
            ),
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: CustomTrackShape(),
                overlayShape: SliderComponentShape.noThumb,
                valueIndicatorColor: Colors.pink,
              ),
              child: Slider(
                value: viewModel.maxDiscount.toDouble(),
                min: 1,
                max: 100,
                divisions: 100,
                activeColor: mainPinkColor,
                mouseCursor: MouseCursor.defer,
                inactiveColor: mainGrayColor,
                label: viewModel.maxDiscount.toString(),
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()}';
                },
                onChanged: viewModel.setDistance,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPayRangeView(
    CandidatePreferenceViewModel viewModel,
  ) {
    return PreferenceCustomUIWidget(
      title: 'pay_range',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "set_payment_range".tr(),
                style: TSB.regularSmall(),
              ),
              Text(
                viewModel.payRangeText,
                style: TSB.regularVSmall(),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.margin_padding_8,
              top: SizeConfig.margin_padding_13,
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
          )
        ],
      ),
    );
  }

  Widget _buildAvailabilityShiftView(
    CandidatePreferenceViewModel viewModel,
  ) {
    return PreferenceCustomUIWidget(
      title: 'availability',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_pre_shift".tr(),
            style: TSB.regularSmall(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_15,
          ),
          Row(
            children: viewModel.availShitList.map(
              (e) {
                var isSelect = viewModel.initialAvailShit == e;
                return InkWell(
                  onTap: () => viewModel.setAvailShit(e),
                  child: _buildCustomSelectBox(
                    text: e,
                    isSelect: isSelect,
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildAvailabilityDateView(
    CandidatePreferenceViewModel viewModel,
  ) {
    return PreferenceCustomUIWidget(
      title: 'by_date',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "set_date_range".tr(),
            style: TSB.regularSmall(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_15,
          ),
          Row(
            children: [
              CustomDatePickerWidget(
                dataType: "from_date",
                data: viewModel.formDateController.text.toDateFormat(),
                onTap: viewModel.pickFormDate,
                initialDate: viewModel.selectedDate,
              ),
              SizedBox(width: SizeConfig.margin_padding_10),
              CustomDatePickerWidget(
                dataType: "to_date",
                initialDate: viewModel.selectedDate,
                data: viewModel.toDateController.text.toDateFormat(),
                onTap: viewModel.pickToDate,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsView(
    CandidatePreferenceViewModel viewModel,
  ) {
    return PreferenceCustomUIWidget(
      title: 'skills',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_pre_skills".tr(),
            style: TSB.regularSmall(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_15,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: viewModel.businessTypeService.gigrrTypeList.map(
              (e) {
                var isSelect = viewModel.addSkillItemList.contains(e);
                return InkWell(
                  onTap: () => viewModel.setSkillsItem(e),
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.margin_padding_13,
                    ),
                    child: _buildCustomSelectBox(
                      text: e.name,
                      isSelect: isSelect,
                    ),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildCustomSelectBox({
    bool isSelect = false,
    String text = "",
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_8,
        horizontal: SizeConfig.margin_padding_13,
      ),
      margin: EdgeInsets.only(
        right: SizeConfig.margin_padding_10,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelect ? mainPinkColor : independenceColor,
        ),
      ),
      child: Text(
        text.tr(),
        style: TSB.regularVSmall(
          textColor: isSelect ? mainPinkColor : mainBlackColor,
        ),
      ),
    );
  }

  Widget _buildSpacer([double? size]) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_20,
    );
  }
}
