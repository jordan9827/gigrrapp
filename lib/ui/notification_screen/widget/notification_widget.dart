import 'package:flutter/material.dart';
import '../../../data/network/dtos/get_notification_response.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationList item;
  NotificationWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(ic_edit_profile),
            radius: SizeConfig.margin_padding_18,
          ),
          SizedBox(
            width: SizeConfig.margin_padding_15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.message,
                  style: TSB.regularLarge(),
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_5,
                ),
                Text(
                  "Oct 16, 2021",
                  style: TSB.regularSmall(textColor: textNoticeColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
