import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../others/loading_button.dart';
import '../../../../others/text_field_widget.dart';
import '../../../../util/others/image_constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
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
                _buildDataPicker(
                  dataType: "from_date",
                  data: widget.viewModel.formDateController.text,
                  onTap: () => selectDatePicker(
                    context,
                    onPicked: widget.viewModel.pickFormDate,
                  ),
                ),
                SizedBox(width: SizeConfig.margin_padding_10),
                _buildDataPicker(
                  dataType: "to_date",
                  data: widget.viewModel.toDateController.text,
                  onTap: () => selectDatePicker(
                    context,
                    onPicked: widget.viewModel.pickToDate,
                  ),
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

  Widget _buildDataPicker({
    required String dataType,
    required String data,
    Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(
            SizeConfig.margin_padding_10,
          ),
          decoration: BoxDecoration(
            color: mainGrayColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataType.tr(),
                style: TextStyle(color: textNoticeColor),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              Row(
                children: [
                  Image.asset(
                    ic_calender_blck,
                    height: SizeConfig.margin_padding_15,
                    color: mainPinkColor,
                  ),
                  SizedBox(
                    width: SizeConfig.margin_padding_5,
                  ),
                  Text(
                    data,
                    style: TSB.regularSmall(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDatePicker(
    BuildContext context, {
    Function(DateTime)? onPicked,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.viewModel.selectedDate,
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
    if (picked != null) {
      onPicked!(picked);
      setState(() {});
    }
  }
}
