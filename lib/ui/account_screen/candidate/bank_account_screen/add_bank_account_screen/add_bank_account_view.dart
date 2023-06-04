import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'add_bank_account_view_model.dart';

class AddBankAccountScreenView extends StatefulWidget {
  const AddBankAccountScreenView({Key? key}) : super(key: key);

  @override
  State<AddBankAccountScreenView> createState() =>
      _AddBankAccountScreenViewState();
}

class _AddBankAccountScreenViewState extends State<AddBankAccountScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddBankAccountViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        appBar: getAppBar(context, ""),
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
