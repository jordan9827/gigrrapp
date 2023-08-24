import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/network/dtos/fetch_upi_detail_response.dart';
import '../../../../../others/common_app_bar.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import 'add_upi_view_model.dart';

class AddUpiView extends StatelessWidget {
  final GetUpiDetailResponseData data;
  const AddUpiView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddUpiViewModel(data, false),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "add_upi",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
        ),
        body: Padding(
          padding: EdgeInsets.all(
            SizeConfig.margin_padding_15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    ic_gigrra_name,
                    height: SizeConfig.margin_padding_40,
                  ),
                  SizedBox(
                    width: SizeConfig.margin_padding_8,
                  ),
                  SizedBox(
                    width: SizeConfig.margin_padding_65,
                    height: SizeConfig.margin_padding_24,
                    child: Image.asset(
                      ic_upi_logo,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.margin_padding_29,
              ),
              CVMTextFormField(
                title: "upi_id",
                hintForm: "simon@okhdfc",
                controller: viewModel.upiController,
              ),
              Spacer(),
              LoadingButton(
                loading: viewModel.isBusy,
                action: viewModel.addUpiId,
                title: "save",
              ),
              SizedBox(
                height: SizeConfig.margin_padding_40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
