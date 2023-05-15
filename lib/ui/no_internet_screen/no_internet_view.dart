import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text("No internet"),
          ),
        ),
      ),
    );
  }
}
