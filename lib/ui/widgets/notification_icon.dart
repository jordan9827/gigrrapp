import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationServices = locator<NavigationService>();

    return Padding(
      padding: EdgeInsets.only(
        right: SizeConfig.margin_padding_10,
      ),
      child: Center(
        child: InkWell(
          onTap: () => navigationServices.navigateTo(
            Routes.notificationScreenView,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: mainBlackColor.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizeConfig.margin_padding_8,
                ),
              ),
            ),
            height: SizeConfig.margin_padding_35,
            width: SizeConfig.margin_padding_35,
            child: Center(
              child: SizedBox(
                height: SizeConfig.margin_padding_16,
                width: SizeConfig.margin_padding_16,
                child: Image.asset(
                  ic_notification_home,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
