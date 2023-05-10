import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../util/others/text_styles.dart';
import 'chat_view_model.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "chat",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.safeBlockHorizontal * 16),
            child: Container(
              margin: edgeInsetsMargin.copyWith(
                bottom: SizeConfig.margin_padding_20,
              ),
              child: Row(
                children: [
                  Image.asset(
                    ic_chat,
                    scale: 3,
                  ),
                  SizedBox(
                    width: SizeConfig.margin_padding_15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GiGi is online",
                        style: TSB.regularMedium(textColor: mainWhiteColor),
                      ),
                      Text(
                        "She will try her best to help you",
                        style: TSB.regularSmall(textColor: mainWhiteColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(child: Text("")),
              _buildBottomBar(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(ChatViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.margin_padding_15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InputFieldWidget(hint: "type_here"),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          Container(
            height: SizeConfig.margin_padding_24 * 1.8,
            width: SizeConfig.margin_padding_24 * 1.8,
            padding: EdgeInsets.all(SizeConfig.margin_padding_10),
            decoration: BoxDecoration(
              color: mainPinkColor,
              borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
            ),
            child: Image.asset(
              ic_send_wht,
              scale: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
