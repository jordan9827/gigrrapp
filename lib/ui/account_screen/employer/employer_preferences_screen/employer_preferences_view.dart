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
import '../../../widgets/custom_drop_down.dart';
import 'employer_preferences_view_model.dart';
import 'preference_custom_ui_widget.dart';

class EmployerPreferenceScreenView extends StatelessWidget {
  const EmployerPreferenceScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.initState(),
      viewModelBuilder: () => EmployerPreferenceViewModel(),
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
                _buildBusinessTypeView(viewModel),
                _buildLocationView(viewModel),
                _buildDistanceView(viewModel),
                _buildAvailabilityShiftView(viewModel),
                _buildAvailabilityDateView(viewModel),
                _buildSkillsView(viewModel),
                _buildSpacer(),
                LoadingButton(
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

  Widget _buildBusinessTypeView(EmployerPreferenceViewModel viewModel) {
    return EmployerPreferenceCustomUIWidget(
      title: "your_businesses",
      padding: SizeConfig.margin_padding_8,
      child: CustomDropDownWidget(
        hintText: "i.e. Shopping Store",
        itemList: viewModel.businessesList.map((e) => e.businessName).toList(),
        visible: viewModel.isVisible,
        groupValue: viewModel.businessController.text,
        onVisible: viewModel.onVisibleAction,
        selectSingleItemsAction: viewModel.onItemSelect,
      ),
    );
  }

  Widget _buildLocationView(EmployerPreferenceViewModel viewModel) {
    return EmployerPreferenceCustomUIWidget(
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
    EmployerPreferenceViewModel viewModel,
  ) {
    return EmployerPreferenceCustomUIWidget(
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

  Widget _buildAvailabilityShiftView(
    EmployerPreferenceViewModel viewModel,
  ) {
    return EmployerPreferenceCustomUIWidget(
      title: 'gender',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_gender".tr(),
            style: TSB.regularSmall(),
          ),
          _buildSpacer(
            SizeConfig.margin_padding_15,
          ),
          Row(
            children: viewModel.genderList.map(
              (e) {
                var isSelect = viewModel.initialGender == e;
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
    EmployerPreferenceViewModel viewModel,
  ) {
    return EmployerPreferenceCustomUIWidget(
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
    EmployerPreferenceViewModel viewModel,
  ) {
    return EmployerPreferenceCustomUIWidget(
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
