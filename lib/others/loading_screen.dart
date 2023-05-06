import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

class LoadingScreen extends StatelessWidget {
  final bool loading;
  final Widget child;
  final bool showDialogLoading;
  const LoadingScreen({
    Key? key,
    this.showDialogLoading = false,
    required this.loading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return !showDialogLoading
        ? loading
            ? Center(
                heightFactor: 10,
                child: SpinKitCircle(
                  size: SizeConfig.margin_padding_40,
                  color: independenceColor,
                ),
              )
            : child
        : _buildDialogLoading();
  }

  Widget _buildDialogLoading() {
    return Stack(
      children: [
        Stack(
          children: [
            child,
            if (loading)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
              )
          ],
        ),
        if (loading)
          Center(
            child: Container(
              width: SizeConfig.margin_padding_65,
              height: SizeConfig.margin_padding_65,
              margin: const EdgeInsets.all(100),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                heightFactor: 10,
                child: SpinKitCircle(
                  size: 25,
                  color: independenceColor,
                ),
              ),
            ),
          )
      ],
    );
  }
}
