import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../util/others/size_config.dart';

class FilterDialogWidget extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const FilterDialogWidget(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: FilterDialogView(request: request, completer: completer),
    );
  }
}

class FilterDialogView extends StatefulWidget {
  const FilterDialogView({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;

  @override
  State<FilterDialogView> createState() => FilterDialogViewState();
}

class FilterDialogViewState extends State<FilterDialogView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: 500,
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/image/close_dark_icon.png",
                height: SizeConfig.margin_padding_20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Filter",
              style: TextStyle(fontSize: SizeConfig.textSizeXLarge),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDataPicker(dataType: "Form Date", data: "18 May 2023"),
              SizedBox(width: SizeConfig.margin_padding_10),
              _buildDataPicker(dataType: "To Date", data: "05 May 2023")
            ],
          ),
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Text(
            "Find by name",
            style: TextStyle(fontSize: SizeConfig.textSizeMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPicker({
    required String dataType,
    required String data,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(
          SizeConfig.margin_padding_10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataType,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/image/close_dark_icon.png",
                  height: SizeConfig.margin_padding_15,
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_5,
                ),
                Text(
                  data,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
