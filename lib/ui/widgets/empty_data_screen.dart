import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';

class EmptyDataScreenView extends StatelessWidget {
  final bool enableBackButton;
  const EmptyDataScreenView({
    Key? key,
    this.enableBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Center(
      child: Container(
        height: SizeConfig.margin_padding_50 * 9,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_29,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ic_empty_data,
              scale: 2.7,
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Text(
              textAlign: TextAlign.center,
              "txt_no_data".tr(),
              style: TSB.regularMedium(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
            if (enableBackButton)
              LoadingButton(
                action: () => Navigator.of(context).pop(),
                title: "go_to_home",
              )
          ],
        ),
      ),
    );
  }
}
