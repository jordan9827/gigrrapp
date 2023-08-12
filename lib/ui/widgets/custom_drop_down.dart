import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../util/others/text_styles.dart';

class CustomDropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final List<String>? onMultiSelectedList;
  final String hintText;
  final Function()? onVisible;
  final Function(String?)? selectSingleItemsAction;
  final Function(int)? removeItems;
  final Function(bool, int)? selectMultipleItemsAction;
  final bool visible;
  final bool enableMultiSelected;
  final String groupValue;
  final double? size;
  final bool isLoading;

  CustomDropDownWidget({
    Key? key,
    required this.itemList,
    this.onVisible,
    this.visible = false,
    this.isLoading = false,
    this.enableMultiSelected = false,
    this.hintText = "",
    this.groupValue = "",
    this.onMultiSelectedList,
    this.removeItems,
    this.selectSingleItemsAction,
    this.selectMultipleItemsAction,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = visible ? 0.0 : 10.0;
    SizeConfig.init(context);
    return Column(
      children: [
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.margin_padding_3 * 2.5,
            horizontal: SizeConfig.margin_padding_10,
          ),
          decoration: BoxDecoration(
            color: mainGrayColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (enableMultiSelected) _buildSelectedContainList(),
              if (!enableMultiSelected) _buildSelectedView(groupValue),
              isLoading
                  ? SpinKitCircle(
                      size: SizeConfig.margin_padding_20,
                      color: independenceColor,
                    )
                  : InkWell(
                      onTap: onVisible,
                      child: Icon(
                        visible
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: independenceColor,
                      ),
                    ),
            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: Container(
            height: setHeightOfDrop(itemList.length),
            decoration: BoxDecoration(
              color: mainGrayColor,
              border: Border(
                top: BorderSide(
                  color: Colors.black38,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.margin_padding_8,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: itemList
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              e.tr(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TSB.regularSmall(),
                            ),
                          ),
                          if (enableMultiSelected)
                            Checkbox(
                              onChanged: (val) => selectMultipleItemsAction!(
                                val ?? false,
                                itemList.indexOf(e),
                              ),
                              value: onMultiSelectedList!.contains(e),
                              activeColor: mainPinkColor,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                            ),
                          if (!enableMultiSelected)
                            Radio(
                              value: e,
                              activeColor: mainPinkColor,
                              groupValue: groupValue,
                              onChanged: selectSingleItemsAction,
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedContainList() {
    return onMultiSelectedList!.isEmpty
        ? Text(
            hintText.tr(),
            style: TSB.regularSmall(textColor: textRegularColor),
          )
        : Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: onMultiSelectedList!
                  .map(
                    (e) => _buildSelectedView(e),
                  )
                  .toList(),
            ),
          );
  }

  Widget _buildSelectedView(String element) {
    return element.isEmpty
        ? Text(
            hintText.tr(),
            style: TSB.regularSmall(textColor: textRegularColor),
          )
        : Container(
            margin: EdgeInsets.only(
              right: SizeConfig.margin_padding_5,
            ),
            padding: EdgeInsets.all(
              SizeConfig.margin_padding_8,
            ),
            decoration: BoxDecoration(
              color: independenceColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  element.tr(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (enableMultiSelected)
                  SizedBox(
                    width: SizeConfig.margin_padding_5,
                  ),
                if (enableMultiSelected)
                  InkWell(
                    onTap: () =>
                        removeItems!(onMultiSelectedList!.indexOf(element)),
                    child: Image.asset(
                      "assets/images/close_dark_icon.png",
                      color: Colors.white,
                      scale: 0.5,
                    ),
                  )
              ],
            ),
          );
  }
}
