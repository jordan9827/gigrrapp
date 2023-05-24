import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../others/constants.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';

class CustomDatePickerWidget extends StatelessWidget {
  final Function(DateTime)? onTap;
  final String dataType;
  final String data;
  final DateTime initialDate;

  const CustomDatePickerWidget({
    Key? key,
    this.onTap,
    required this.dataType,
    required this.data,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Expanded(
      child: InkWell(
        onTap: () => selectDatePicker(
          context,
          onPicked: onTap,
        ),
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
      initialDate: initialDate,
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
    }
  }
}
