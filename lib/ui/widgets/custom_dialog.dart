import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:store_redirect/store_redirect.dart';

class CMDialog extends StatelessWidget {
  final bool isForceUpdate;

  const CMDialog({
    Key? key,
    this.isForceUpdate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Center(
      child: Container(
        height: SizeConfig.margin_padding_50 * 3,
        width: SizeConfig.screenWidth / 1.25,
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.margin_padding_15,
              horizontal: SizeConfig.margin_padding_18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isForceUpdate ? "Update Required" : "Update Available",
                  style: TSB.semiBoldLarge(),
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_10,
                ),
                Text(
                  "New Version Available.\nPlease Update App",
                  style: TSB.regularSmall(textColor: textNoticeColor),
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_15,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!isForceUpdate)
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "CANCEL",
                          style: TSB.regularSmall(textColor: Colors.red),
                        ),
                      ),
                    SizedBox(
                      width: SizeConfig.margin_padding_15,
                    ),
                    InkWell(
                      onTap: openStore,
                      child: Text(
                        "Update Now".toUpperCase(),
                        style: TSB.regularSmall(textColor: mainBlueColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openStore() {
    StoreRedirect.redirect(
      androidAppId: "com.tarch.gigrr",
      iOSAppId: "",
    );
  }
}
