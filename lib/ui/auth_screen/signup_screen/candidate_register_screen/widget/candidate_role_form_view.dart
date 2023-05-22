import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/cvm_text_form_field.dart';
import '../candidate_register_view_model.dart';

class CandidateRoleFormView extends StatelessWidget {
  final CandidateRegisterViewModel viewModel;

  const CandidateRoleFormView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return LoadingScreen(
      loading: viewModel.isBusy,
      showDialogLoading: true,
      child: Scaffold(
        body: _buildFormView(viewModel),
      ),
    );
  }

  Widget _buildFormView(CandidateRegisterViewModel viewModel) {
    return Container(
      padding: edgeInsetsMargin,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_24,
          ),
          CVMTextFormField(
            title: "i_can_be",
            hintForm: "Delivery Boy, Sales Man",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          _buildCustomView(
            title: "i_am_avail",
            child: _buildMyAvailableView(),
          ),
          _buildCustomView(
            title: "select_shift",
            child: _buildSelectShiftView(),
          ),
          Spacer(),
          LoadingButton(
            action: viewModel.addProfileApiCall,
            title: "create_profile",
          ),
          SizedBox(
            height: SizeConfig.margin_padding_29,
          )
        ],
      ),
    );
  }

  Widget _buildCustomView({String title = "", required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
          ),
          child: Text(
            title.tr(),
            style: TSB.regularSmall(),
          ),
        ),
        child,
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }

  Widget _buildSelectShiftView() {
    return Row(
      children: viewModel.shiftList
          .map(
            (e) => Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_20,
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
                    groupValue: viewModel.initialShift,
                    onChanged: viewModel.setShift,
                  ),
                  Text(
                    e.tr(),
                    style: TSB.regularSmall(
                      textColor: viewModel.initialShift != e
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

  Widget _buildMyAvailableView() {
    var _list = viewModel.myAvailableList;
    return Row(
      children: _list
          .map(
            (e) => Container(
              margin: EdgeInsets.only(
                right: SizeConfig.margin_padding_20,
              ),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (val) => viewModel.onAvailableItemSelect(
                      val ?? false,
                      _list.indexOf(e),
                    ),
                    value: viewModel.myAvailableSelectList.contains(e),
                    activeColor: mainPinkColor,
                    visualDensity: VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                  Text(
                    e.tr(),
                    style: TSB.regularSmall(
                      textColor: viewModel.myAvailableSelectList.contains(e)
                          ? mainBlackColor
                          : textRegularColor,
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
