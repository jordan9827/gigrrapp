import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../others/constants.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../widgets/notification_icon.dart';

class HomeGigrrsAppBarView extends StatelessWidget {
  final Function() actionToAddress;
  final String addressType;
  final String address;

  const HomeGigrrsAppBarView({
    Key? key,
    required this.actionToAddress,
    this.addressType = "",
    this.address = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return AppBar(
      elevation: 0,
      backgroundColor: mainWhiteColor,
      leadingWidth: 0,
      title: Row(
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_20,
            width: SizeConfig.margin_padding_20,
            child: Image.asset(
              ic_location_filled,
            ),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          Expanded(
            child: InkWell(
              onTap: actionToAddress,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        addressType.tr(),
                        style: TextStyle(
                          color: mainBlackColor,
                          fontWeight: FontWeight.w900,
                          fontSize: SizeConfig.textSizeSmall,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: mainBlackColor,
                      )
                    ],
                  ),
                  Text(
                    address,
                    style: TextStyle(
                      color: mainBlackColor,
                      fontSize: SizeConfig.textSizeVerySmall * 0.95,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        NotificationIcon(),
      ],
    );
  }
}
