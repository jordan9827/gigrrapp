import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../others/constants.dart';
import '../../others/loading_screen.dart';
import '../../others/text_field_widget.dart';
import '../../util/others/size_config.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder<LoginViewViewModel>.reactive(
      viewModelBuilder: () => LoginViewViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_24,
        ),
        InputFieldWidget(
          hint: "Full Name",
          labelText: "Full Name",
          prefixIcon: Icon(
            Icons.person_2_outlined,
            color: mainColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        InputFieldWidget(
          hint: "Email Address",
          labelText: "Email",
          prefixIcon: Icon(
            Icons.alternate_email_outlined,
            color: mainColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        InputFieldWidget(
          hint: "Phone Number",
          labelText: "Phone",
          prefixIcon: Icon(
            Icons.phone_iphone,
            color: mainColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        InputFieldWidget(
          hint: "Password",
          labelText: "Password",
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: mainColor,
          ),
        ),
        Spacer(),
        _buildLoginActionButton(),
        SizedBox(
          height: SizeConfig.margin_padding_29,
        ),
        Text(
          "I already have an account",
          style: TextStyle(
            color: mainColor,
            fontSize: SizeConfig.textSizeSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_29,
        ),
      ],
    );
  }

  Widget _buildLoginActionButton() {
    return Container(
      height: kToolbarHeight * 0.80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.textSizeMedium,
          ),
        ),
      ),
    );
  }
}
