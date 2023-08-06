import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';

class DeleteAccountDialogHelper {
  static dialogBoxAndroid(
    context, {
    required Function() action,
  }) {
    var theme = Theme.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(
            SizeConfig.margin_padding_24,
            SizeConfig.margin_padding_10,
            0,
            0,
          ),
          title: _buildTitleWidget(theme),
          content: _buildContentWidget(theme),
          actions: [
            MaterialButton(
              child: _buildCancelTextWidget(),
              onPressed: () => Navigator.pop(context),
            ),
            MaterialButton(
              child: _buildDeleteTextWidget(),
              onPressed: action,
            ),
          ],
        );
      },
    );
  }

  static dialogBoxIOS(
    context, {
    required Function() action,
  }) {
    var theme = Theme.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return CupertinoAlertDialog(
          title: _buildTitleWidget(theme),
          content: _buildContentWidget(theme),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: _buildCancelTextWidget(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: action,
              child: _buildDeleteTextWidget(),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildTitleWidget(ThemeData theme) {
    return Text(
      "txt_alert".tr(),
      style: TSB.semiBoldMedium(),
    );
  }

  static Widget _buildContentWidget(ThemeData theme) {
    return Text(
      "txt_are_you_delete_acc".tr(),
      style: TSB.regularSmall(),
    );
  }

  static Widget _buildCancelTextWidget({Color? color}) {
    return Text(
      "cancel".tr(),
      style: TSB.semiBoldSmall(),
    );
  }

  static Widget _buildDeleteTextWidget() {
    return Text(
      "delete".tr(),
      style: TSB.semiBoldSmall(
        textColor: Colors.red,
      ),
    );
  }
}
