import 'package:easy_localization/easy_localization.dart';

extension StringExtensions on String {
  String toDateFormat() =>
      DateFormat("dd MMM, yyyy").format(DateTime.parse(this));

  double getNumber({int p = 2}) =>
      double.parse('$this'.substring(0, '$this'.indexOf('.')));

  String toPriceFormat([int p = 2]) {
    return "${double.parse(this).toStringAsFixed(p)}";
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
