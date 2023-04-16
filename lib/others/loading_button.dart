import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';

//updated according to new ui
class LoadingButton extends StatelessWidget {
  final bool loading;
  final Function action;
  final bool enabled;
  final Widget child;
  final Color progressIndicatorColor;

  const LoadingButton({
    Key? key,
    this.loading = false,
    this.enabled = true,
    this.progressIndicatorColor = Colors.white,
    required this.action,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: ElevatedButton(
        onPressed: enabled ? () => action() : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: mainColor,
        ),
        child: loading
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: progressIndicatorColor,
                ),
              )
            : child,
      ),
    );
  }
}
