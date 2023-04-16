import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/signup_screen/signup_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../others/constants.dart';
import '../../others/loading_button.dart';
import '../../others/loading_screen.dart';
import '../../others/text_field_widget.dart';
import '../../util/others/size_config.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder<SignUpViewViewModel>.reactive(
      viewModelBuilder: () => SignUpViewViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: Container(),
        ),
      ),
    );
  }
}
