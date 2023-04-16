import 'dart:math';

extension DoubleExtensions on double {
  String toPriceFormat([int precision = 2]) {
    final priceFormat = this.truncateToDecimalPlaces(precision);
    final priceSplit = priceFormat.split(r'.');

    if (priceSplit.length == 2 && priceSplit[0].length > 3) {
      var commaList = priceSplit[0].substring(0, priceSplit[0].length - 3);
      commaList = commaList.replaceAllMapped(
          RegExp(r'(\d{1,2})(?=(\d{2})+(?!\d))'), (Match m) => '${m[1]},');
      return '$commaList,${priceSplit[0].substring(priceSplit[0].length - 3)}.${priceSplit[1]}';
    }
    return priceFormat;
  }

  String truncateToDecimalPlaces(int fractionalDigits) =>
      ((this * pow(10, fractionalDigits)).truncate() /
              pow(10, fractionalDigits))
          .toString();
}
