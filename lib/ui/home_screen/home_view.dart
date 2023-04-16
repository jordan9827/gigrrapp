import 'package:flutter/material.dart';
import 'package:square_demo_architecture/main.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../others/constants.dart';
import 'home_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.textSizeHeading,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
