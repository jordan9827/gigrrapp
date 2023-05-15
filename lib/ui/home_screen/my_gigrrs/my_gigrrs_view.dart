import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/my_gigrrs_view_model.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

class MyGirrsView extends StatelessWidget {
  const MyGirrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MyGirrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Center(
            child: Text(
              "Coming soon",
              style: TextStyle(
                color: mainBlackColor,
                fontSize: SizeConfig.textSizeSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
