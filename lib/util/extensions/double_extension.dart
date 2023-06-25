import 'dart:math';

extension DoubleExtensions on double {
  String truncateToDecimalPlaces(int fractionalDigits) =>
      ((this * pow(10, fractionalDigits)).truncate() /
              pow(10, fractionalDigits))
          .toString();
}
