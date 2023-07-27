import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/add_gigs/add_gigs_view_model.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import '../../../others/constants.dart';
import '../../../others/loading_button.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../../widgets/cvm_text_form_field.dart';
import 'package:stacked/stacked.dart';

class AddGigsOperationalInfoScreenView
    extends ViewModelWidget<AddGigsViewModel> {
  @override
  Widget build(BuildContext context, AddGigsViewModel viewModel) {
    return _buildFormView(viewModel, context);
  }

  Widget _buildFormView(AddGigsViewModel viewModel, BuildContext context) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Text(
            "job_duration".tr(),
            style: TSB.semiBoldSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_13,
          ),
          CVMTextFormField(
            title: "from_date",
            hintForm: "i.e. 18 Feb 2023",
            readOnly: true,
            controller: viewModel.formDateController,
            suffixIcon: _buildImage(
              image: ic_calender_blck,
              onTap: () => viewModel.selectDatePicker(
                context,
                initialDate: viewModel.selectedDate,
                textController: viewModel.formDateController,
              ),
            ),
          ),
          CVMTextFormField(
            title: "to_date",
            hintForm: "i.e. 18 Feb 2023",
            readOnly: true,
            controller: viewModel.toDateController,
            suffixIcon: _buildImage(
              image: ic_calender_blck,
              onTap: () => viewModel.selectDatePicker(
                context,
                initialDate: viewModel.selectedDate,
                textController: viewModel.toDateController,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Text(
            "job_timing".tr(),
            style: TSB.semiBoldSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_13,
          ),
          CVMTextFormField(
            title: "from_time",
            hintForm: "i.e. 08:00 AM",
            readOnly: true,
            controller: viewModel.formTimeController,
            suffixIcon: _buildImage(
              image: ic_clock_blck,
              onTap: () => viewModel.selectTimePicker(
                context,
                initialTime: viewModel.selectedTime,
                textController: viewModel.formTimeController,
              ),
            ),
          ),
          CVMTextFormField(
            title: "to_time",
            hintForm: "i.e. 08:00 AM",
            readOnly: true,
            controller: viewModel.toTimeController,
            suffixIcon: _buildImage(
              image: ic_clock_blck,
              onTap: () => viewModel.selectTimePicker(
                context,
                initialTime: viewModel.selectedTime,
                textController: viewModel.toTimeController,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          LoadingButton(
            loading: viewModel.isBusy,
            action: viewModel.addGigrrApiCall,
            title: "confirmed_add_now".tr(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildImage({
    required String image,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.margin_padding_10),
        height: SizeConfig.margin_padding_15,
        width: SizeConfig.margin_padding_15,
        child: Image.asset(image),
      ),
    );
  }
}
