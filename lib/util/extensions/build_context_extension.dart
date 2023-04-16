import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  Size get dimension => MediaQuery.of(this).size;
}