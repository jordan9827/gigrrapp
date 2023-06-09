import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../others/loading_button.dart';
import '../../../../others/text_field_widget.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/custom_date_picker.dart';
import '../payment_history_view_model.dart';

class FilterDialogView extends StatefulWidget {
  final PaymentHistoryViewModel viewModel;
  const FilterDialogView({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterDialogView> createState() => FilterDialogViewState();
}

class FilterDialogViewState extends State<FilterDialogView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_20,
          vertical: SizeConfig.margin_padding_15,
        ),
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  ic_close_blck,
                  height: SizeConfig.margin_padding_13,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_10,
            ),
            Text(
              "filter".tr(),
              style: TSB.semiBoldHeading(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Text(
              "by_date_range".tr(),
              style: TSB.regularSmall(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Row(
              children: [
                CustomDatePickerWidget(
                  dataType: "from_date",
                  initialDate: widget.viewModel.selectedDate,
                  data: widget.viewModel.formDateController.text,
                  onTap: widget.viewModel.pickFormDate,
                ),
                SizedBox(width: SizeConfig.margin_padding_10),
                CustomDatePickerWidget(
                  dataType: "to_date",
                  initialDate: widget.viewModel.selectedDate,
                  data: widget.viewModel.toDateController.text,
                  onTap: widget.viewModel.pickToDate,
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Text(
              "find_by_name".tr(),
              style: TSB.regularSmall(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            InputFieldWidget(
              hint: 'Name',
              controller: widget.viewModel.nameController,
              prefixIcon: Image.asset(ic_search_blck, scale: 3),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            LoadingButton(
              action: () {},
              title: 'apply',
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "clear".tr(),
                style: TSB.regularSmall(textColor: textNoticeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
