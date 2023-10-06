import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import 'candidate_gigs_screen/candidate_gigs_view.dart';
import 'employer_gigs_screen/employer_gigs_view.dart';
import 'my_gigs_view_model.dart';

class MyGigs extends StatelessWidget {
  final int initial;
  const MyGigs({Key? key,  this.initial=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MyGigsViewModel(),
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () => Future.sync(viewModel.onWillPop),
          child: viewModel.user.isEmployer
              ? EmployerGigsView()
              : CandidateGigsView(initial: initial),
        );
      },
    );
  }
}
