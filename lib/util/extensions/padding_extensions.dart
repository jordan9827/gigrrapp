import 'package:flutter/cupertino.dart';

extension PaddingExtensions on Widget
{
   Padding toHorizontalPadding(double value) => Padding(padding: EdgeInsets.symmetric(horizontal: value),child: this);
}