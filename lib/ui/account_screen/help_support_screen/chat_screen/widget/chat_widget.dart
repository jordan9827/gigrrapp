import 'package:flutter/cupertino.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';

class ChatWidgetView extends StatelessWidget {
  final String text;
  final bool isCurrentUser;
  const ChatWidgetView({
    Key? key,
    this.text = "",
    this.isCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Color bocColor = isCurrentUser
        ? lightPinkColor
        : fieldsActiveElementColor2.withOpacity(0.14);
    var scale = SizeConfig.margin_padding_10;
    var paddingR = !isCurrentUser ? SizeConfig.margin_padding_65 : scale * 2;
    var paddingL = isCurrentUser ? SizeConfig.margin_padding_65 : scale * 2;
    return Align(
      alignment: !isCurrentUser ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.margin_padding_5,
          bottom: SizeConfig.margin_padding_5,
          right: paddingR,
          left: paddingL,
        ),
        padding: EdgeInsets.symmetric(
          vertical: scale,
          horizontal: scale * 1.3,
        ),
        decoration: BoxDecoration(
          color: bocColor,
          borderRadius: BorderRadius.only(
            bottomRight: !isCurrentUser ? Radius.zero : Radius.circular(scale),
            bottomLeft: isCurrentUser ? Radius.zero : Radius.circular(scale),
            topLeft: Radius.circular(scale),
            topRight: Radius.circular(scale),
          ),
        ),
        child: Text(
          text,
          style: TSB.regularSmall(
            textColor: textRegularColor,
          ),
        ),
      ),
    );
  }
}
