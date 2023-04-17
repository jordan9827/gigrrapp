import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'personal_register_view_model.dart';

class PersonalRegisterView extends StatefulWidget {
  const PersonalRegisterView({Key? key}) : super(key: key);

  @override
  State<PersonalRegisterView> createState() => _PersonalRegisterViewState();
}

class _PersonalRegisterViewState extends State<PersonalRegisterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PersonalRegisterViewModel(),
        builder: (context, viewModel, child) => Scaffold());
  }
}
