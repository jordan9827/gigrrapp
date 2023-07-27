import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';

class DetailAppBar extends StatefulWidget {
  const DetailAppBar({Key? key}) : super(key: key);

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    MediaQueryData mediaQueryData = context.mediaQueryData;
    double outerPadding = SizeConfig.margin_padding_15;
    return Container(
      height: kToolbarHeight,
      width: mediaQueryData.size.width,
      padding: EdgeInsets.only(
        right: outerPadding,
        left: outerPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAppBarButtons(
            icon: grop_arrow_icon,
            onTap: () => locator<NavigationService>().back(),
          ),
          _buildAppBarButtons(
            icon: grop_icon,
            onTap: () => locator<NavigationService>().back(),
          )
        ],
      ),
    );
  }

  Widget _buildAppBarButtons({
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(icon, scale: 2.8),
    );
  }
}
