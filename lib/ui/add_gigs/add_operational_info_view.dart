import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/add_gigs/add_gigs_view_model.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:stacked/stacked.dart';

import '../../others/constants.dart';
import '../../others/loading_button.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';
import '../widgets/cvm_text_form_field.dart';

class AddGigsOperationalInfoScreenView extends StatelessWidget {
  final AddGigsViewModel viewModel;
  const AddGigsOperationalInfoScreenView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFormView(viewModel);
  }

  Widget _buildFormView(AddGigsViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
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
            suffixIcon: _buildImage(ic_calender_blck),
          ),
          CVMTextFormField(
            title: "to_date",
            hintForm: "i.e. 18 Feb 2023",
            suffixIcon: _buildImage(ic_calender_blck),
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
            suffixIcon: _buildImage(ic_clock_blck),
          ),
          CVMTextFormField(
            title: "to_time",
            hintForm: "i.e. 08:00 AM",
            suffixIcon: _buildImage(ic_clock_blck),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          LoadingButton(
            action: viewModel.navigationToNextPage,
            title: "confirmed_add_now".tr(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.margin_padding_10),
      height: SizeConfig.margin_padding_15,
      width: SizeConfig.margin_padding_15,
      child: Image.asset(image),
    );
  }
}
