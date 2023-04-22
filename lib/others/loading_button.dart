import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';

import '../util/others/text_styles.dart';

//updated according to new ui
class LoadingButton extends StatelessWidget {
  final bool loading;
  final Function action;
  final bool enabled;
  final String title;
  final Color progressIndicatorColor;
  final Color backgroundColor;
  final Color titleColor;

  const LoadingButton({
    Key? key,
    this.loading = false,
    this.enabled = true,
    this.progressIndicatorColor = Colors.white,
    this.backgroundColor = mainPinkColor,
    this.titleColor = mainWhiteColor,
    required this.action,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight * 0.82,
      width: MediaQuery.of(context).size.height,
      child: AbsorbPointer(
        absorbing: loading,
        child: ElevatedButton(
          onPressed: enabled ? () => action() : null,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: backgroundColor,
          ),
          child: loading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: progressIndicatorColor,
                  ),
                )
              : Text(
                  title.tr(),
                  style: TSB.regularMedium(textColor: titleColor),
                ),
        ),
      ),
    );
  }
}
