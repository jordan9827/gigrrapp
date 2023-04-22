import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../util/others/text_styles.dart';

PreferredSizeWidget getAppBar(
  BuildContext context,
  String title, {
  bool showBack = false,
  onBackPressed,
  List<Widget>? actions,
  Color? backgroundColor,
}) {
  SizeConfig.init(context);
  return AppBar(
    actions: actions,
    title: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title.tr(),
        style: TSB.regularLarge(
          textColor: Colors.white,
        ),
      ),
    ),
    leading: showBack
        ? InkWell(
            child: Image.asset(
              arrow_back,
              scale: 2,
            ),
            onTap: onBackPressed,
          )
        : null,
    titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
    automaticallyImplyLeading: showBack,
    elevation: 0,
    backgroundColor:
        backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
  );
}
