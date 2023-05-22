import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/cvm_text_form_field.dart';
import 'package:square_demo_architecture/ui/widgets/map_box/google_map_box_view.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../widgets/custom_image_picker/custom_image_picker_view.dart';
import '../candidate_register_view_model.dart';

class CandidatePersonalInfoFormView extends StatelessWidget {
  final CandidateRegisterViewModel viewModel;

  const CandidatePersonalInfoFormView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.isBusy,
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
          CVMTextFormField(
            title: "full_name",
            hintForm: "i.e. Jack Milton",
            controller: viewModel.fullNameController,
          ),
          CVMTextFormField(
            maxLength: 10,
            title: "mobile_number",
            hintForm: "i.e. 989 898 9898",
            controller: viewModel.mobileController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          CVMTextFormField(
            readOnly: true,
            title: "date_of_birth",
            hintForm: "i.e. 18 Feb 2023",
            controller: viewModel.dobController,
            suffixIcon: InkWell(
              onTap: () => selectDatePicker(context, viewModel: viewModel),
              child: Container(
                padding: EdgeInsets.all(SizeConfig.margin_padding_10),
                height: SizeConfig.margin_padding_15,
                width: SizeConfig.margin_padding_15,
                child: Image.asset(
                  ic_calender_blck,
                ),
              ),
            ),
          ),
          _buildSetGender(viewModel),
          CVMTextFormField(
            title: "address",
            readOnly: true,
            controller: viewModel.addressController,
            hintForm: "i.e. House no., Street name, Area",
            onTap: viewModel.mapBoxPlace,
          ),
          CVMTextFormField(
            title: "city",
            controller: viewModel.cityController,
            hintForm: "i.e. Indore",
          ),
          CVMTextFormField(
            title: "state",
            controller: viewModel.stateController,
            hintForm: "i.e. Madhya Pradesh",
          ),
          CVMTextFormField(
            title: "pinCode",
            controller: viewModel.pinCodeController,
            hintForm: "i.e. 452001",
          ),
          CVMTextFormField(
            title: "upload_business_pictures",
            formWidget: CustomImagePickerView(
              imageList: viewModel.imageList,
            ),
          ),
          LoadingButton(
            action: viewModel.navigationToRoleFormView,
            title: "next_to_role_avail",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildSetGender(CandidateRegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
          child: Text(
            "select_gender".tr(),
            style: TSB.regularSmall(),
          ),
        ),
        Row(
          children: viewModel.genderList
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
                        groupValue: viewModel.initialGender,
                        onChanged: viewModel.setGender,
                      ),
                      Text(
                        e.tr(),
                        style: TSB.regularSmall(
                          textColor: viewModel.initialGender != e
                              ? textRegularColor
                              : mainBlackColor,
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Future<void> selectDatePicker(
    BuildContext context, {
    required CandidateRegisterViewModel viewModel,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: viewModel.selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: independenceColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: independenceColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) viewModel.setPickDate(picked);
  }
}
