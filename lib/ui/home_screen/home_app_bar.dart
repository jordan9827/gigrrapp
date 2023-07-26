import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';
import '../../others/constants.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../widgets/notification_icon.dart';

class HomeGigrrsAppBarView extends StatelessWidget {
  final Function() actionToAddress;
  const HomeGigrrsAppBarView({
    Key? key,
    required this.actionToAddress,
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
                        "Shop",
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
                    locator<UserAuthResponseData>().address,
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
