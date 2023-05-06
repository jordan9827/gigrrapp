import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/add_gigs/add_gigs_view_model.dart';
import '../../../others/constants.dart';
import '../../../others/loading_button.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import '../../gigrr_type_drop_down_screen/gigrr_type_drop_down_view.dart';
import '../../widgets/cvm_text_form_field.dart';
import '../../business_type_drop_down_screen/business_type_drop_down_view.dart';

class AddGigsInfoScreenView extends StatelessWidget {
  final AddGigsViewModel viewModel;
  const AddGigsInfoScreenView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(viewModel.onWillPop),
      child: _buildFormView(viewModel),
    );
  }

  Widget _buildFormView(AddGigsViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: ListView(
        children: [
          CVMTextFormField(
            title: "gig_name",
            controller: viewModel.gigrrNameController,
            hintForm: "i.e. Kirana Shop Delivery Boy",
          ),
          BusinessTypeDropDownView(
            onCallBack: (val) {
              viewModel.gigrrNameController.text = val!;
              print("objectjdkji${viewModel.gigrrNameController.text}");
            },
          ),
          GigrrTypeDropDownView(
            controller: viewModel.gigrrTypeController,
          ),
          Text(
            "i_will_to_pay".tr(),
            style: TSB.semiBoldSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_8,
          ),
          _buildSetPriceView(viewModel),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          CVMTextFormField(
            title: "",
            controller: viewModel.priceController,
            hintForm: "i.e. ₹ 400",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          LoadingButton(
            action: viewModel.navigationToNextPage,
            title: "next_add_operation".tr(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildSetPriceView(AddGigsViewModel viewModel) {
    return Row(
      children: viewModel.priceList
          .map(
            (e) => Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_15,
              ),
              child: Row(
                children: [
                  Radio<String>(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    activeColor: mainPinkColor,
                    value: e,
                    groupValue: viewModel.initialPrice,
                    onChanged: viewModel.setPrice,
                  ),
                  Text(
                    e.tr(),
                    style: TSB.regularSmall(
                      textColor: viewModel.initialPrice != e
                          ? textRegularColor
                          : mainBlackColor,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
