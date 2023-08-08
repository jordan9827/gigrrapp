import 'dart:math';

import '../others/size_config.dart';

extension DoubleExtensions on double {
  String truncateToDecimalPlaces(int fractionalDigits) =>
      ((this * pow(10, fractionalDigits)).truncate() /
              pow(10, fractionalDigits))
          .toString();
}
