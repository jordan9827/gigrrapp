import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../../../util/others/text_styles.dart';
import 'chat_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'widget/chat_widget.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) async {
        await viewModel.fetchChatList();
      },
      viewModelBuilder: () => ChatViewModel(),
      builder: (_, viewModel, child) => LoadingScreen(
        showDialogLoading: true,
        loading: viewModel.isLoading,
        child: Scaffold(
          appBar: getAppBar(
            context,
            "chat",
            showBack: true,
            onBackPressed: viewModel.navigationToBack,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                SizeConfig.safeBlockHorizontal * 16,
              ),
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
                          "gigi_is_online".tr(),
                          style: TSB.regularMedium(
                            textColor: mainWhiteColor,
                          ),
                        ),
                        Text(
                          "msg_title_chat".tr(),
                          style: TSB.regularSmall(
                            textColor: mainWhiteColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_10,
              ),
              Expanded(
                child: viewModel.helpChatList.isEmpty
                    ? _buildEmptyList()
                    : _buildChatList(viewModel),
              ),
              _buildBottomBar(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(ChatViewModel viewModel) {
    return ListView(
      reverse: true,
      shrinkWrap: true,
      controller: viewModel.controller,
      children: viewModel.helpChatList.map(
        (e) {
          bool isUser = (viewModel.user.id == e.fromUserId ? true : false);
          return ChatWidgetView(
            isCurrentUser: isUser,
            text: e.message,
          );
        },
      ).toList(),
    );
  }

  Widget _buildBottomBar(ChatViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(
        SizeConfig.margin_padding_15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InputFieldWidget(
              hint: "type_here",
              controller: viewModel.chatTextController,
            ),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_10,
          ),
          InkWell(
            onTap: viewModel.sentChat,
            child: Container(
              height: SizeConfig.margin_padding_24 * 1.8,
              width: SizeConfig.margin_padding_24 * 1.8,
              padding: EdgeInsets.all(
                SizeConfig.margin_padding_10,
              ),
              decoration: BoxDecoration(
                color: mainPinkColor,
                borderRadius: BorderRadius.circular(
                  SizeConfig.margin_padding_10,
                ),
              ),
              child: viewModel.isBusy
                  ? SpinKitCircle(
                      size: SizeConfig.margin_padding_20,
                      color: Colors.white,
                    )
                  : Image.asset(
                      ic_send_wht,
                      scale: 2.5,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Image.asset(
        ic_empty_data,
        scale: 3,
      ),
    );
  }
}
