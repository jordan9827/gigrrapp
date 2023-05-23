import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:stacked/stacked.dart';
import '../../../others/loading_button.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'candidate_preferences_view_model.dart';
import 'preference_custom_ui_widget.dart';

class CandidatePreferenceScreenView extends StatefulWidget {
  const CandidatePreferenceScreenView({Key? key}) : super(key: key);

  @override
  State<CandidatePreferenceScreenView> createState() =>
      _CandidatePreferenceScreenViewState();
}

class _CandidatePreferenceScreenViewState
    extends State<CandidatePreferenceScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (v) => v.init(),
      viewModelBuilder: () => CandidatePreferenceViewModel(),
      builder: (_, viewModel, child) => LoadingScreen(
        loading: viewModel.isBusy,
        showDialogLoading: true,
        child: Scaffold(
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "gig_preference",
            textColor: mainBlackColor,
            backgroundColor: mainWhiteColor,
            actions: [
              Container(
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
            ],
          ),
          body: Container(
            padding: edgeInsetsMargin,
            child: ListView(
              children: [
                _buildLocationView(),
                _buildDistanceView(viewModel),
                _buildPayRangeView(viewModel),
                _buildAvailabilityShiftView(viewModel),
                _buildSkillsView(viewModel),
                SizedBox(
                  height: SizeConfig.margin_padding_20,
                ),
                LoadingButton(
                  action: () {},
                  title: 'submit',
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationView() {
    return PreferenceCustomUIWidget(
      title: 'location',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              "11-PU3, Agra Bombay Road, Near C21 Mall, MR-9, Indore MP - 452010",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TSB.regularVSmall(),
            ),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          Container(
            padding: EdgeInsets.all(SizeConfig.margin_padding_8),
            decoration: BoxDecoration(
              color: mainBlueColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.my_location_outlined,
              color: mainPinkColor,
              size: 25,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDistanceView(CandidatePreferenceViewModel viewModel) {
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
                overlayShape: SliderComponentShape.noThumb,
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

  Widget _buildPayRangeView(CandidatePreferenceViewModel viewModel) {
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
                overlayShape: SliderComponentShape.noThumb,
              ),
              child: RangeSlider(
                activeColor: mainPinkColor,
                inactiveColor: mainGrayColor,
                values: viewModel.currentRangeValues,
                max: viewModel.max,
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

  Widget _buildAvailabilityShiftView(CandidatePreferenceViewModel viewModel) {
    return PreferenceCustomUIWidget(
      title: 'availability',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_pre_shift".tr(),
            style: TSB.regularSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            children: viewModel.availShitList.map(
              (e) {
                var isCheck = viewModel.initialAvailShit == e;
                return InkWell(
                  onTap: () => viewModel.setAvailShit(e),
                  child: Container(
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
                        color: isCheck ? mainPinkColor : independenceColor,
                      ),
                    ),
                    child: Text(
                      e,
                      style: TSB.regularVSmall(
                        textColor: isCheck ? mainPinkColor : independenceColor,
                      ),
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

  Widget _buildSkillsView(CandidatePreferenceViewModel viewModel) {
    return PreferenceCustomUIWidget(
      title: 'skills',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_pre_skills".tr(),
            style: TSB.regularSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            children: viewModel.businessTypeService.gigrrTypeList.map(
              (e) {
                return InkWell(
                  onTap: () => viewModel.setGigrrTypeSkills(e),
                  child: Container(
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
                        color: mainPinkColor,
                      ),
                    ),
                    child: Text(
                      e.name,
                      style: TSB.regularVSmall(
                        textColor: mainPinkColor,
                      ),
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
}
