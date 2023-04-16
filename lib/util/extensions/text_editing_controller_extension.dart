import 'package:flutter/cupertino.dart';

extension TextEditingControllerExtension on TextEditingController {
  void cancelEditing() {
    this.value = TextEditingValue(
      text: this.text
          .replaceRange(this.text.length - 1, null, ''),
      selection:
      TextSelection.collapsed(offset: this.text.length - 1),
    );
  }
}