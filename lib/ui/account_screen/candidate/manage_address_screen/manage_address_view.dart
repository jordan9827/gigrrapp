import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/get_address_response.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/loading_screen.dart';
import 'manage_address_view_model.dart';

class ManageAddressScreenView extends StatelessWidget {
  const ManageAddressScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchAddress(),
      viewModelBuilder: () => ManageAddressViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "manage_address",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
          actions: [
            InkWell(
              onTap: viewModel.navigationToAddAddressView,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  color: mainWhiteColor,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: Container(
            margin: edgeInsetsMargin,
            child: ListView(
              children: [
                SizedBox(
                  height: SizeConfig.margin_padding_15,
                ),
                Column(
                  children: viewModel.addressList
                      .map(
                        (e) => _buildAddressView(viewModel, e),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressView(
      ManageAddressViewModel viewModel, GetAddressResponseData data) {
    return Container(
      padding: EdgeInsets.all(
        SizeConfig.margin_padding_10,
      ),
      margin: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_10,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            iconsWidget("office"),
            color: independenceColor,
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.addressType.capitalize(),
                  style: TSB.semiBoldMedium(),
                ),
                SizedBox(height: 3),
                Text(
                  data.address,
                  style: TSB.regularVSmall(
                    textColor: textRegularColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          InkWell(
            onTap: () => viewModel.navigationToEditAddressView(data),
            child: Icon(
              Icons.border_color_outlined,
              color: textRegularColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData iconsWidget(String text) {
    if (text == "home") {
      return Icons.home_outlined;
    } else if (text == "office") {
      return Icons.location_city_outlined;
    } else {
      return Icons.location_on_outlined;
    }
  }
}
