import 'package:easy_localization/easy_localization.dart';

extension StringExtensions on String {
  String toDateFormat() =>
      DateFormat("dd MMM yyyy").format(DateTime.parse(this));

  bool validateIFSC(String ifsc) =>
      RegExp(r"^[A-Z]{4}0[A-Z0-9]{6}$").hasMatch(ifsc);
}
