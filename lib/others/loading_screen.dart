import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  final bool loading;
  final Widget child;
  const LoadingScreen({
    Key? key,
    required this.loading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              width: 70,
              height: 70,
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
                  color: Colors.amber,
                ),
              ),
            ),
          )
      ],
    );
  }
}
