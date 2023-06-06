import 'package:easy_localization/easy_localization.dart';

extension StringExtensions on String {
  String toDateFormat() =>
      DateFormat("dd MMM yyyy").format(DateTime.parse(this));
}
