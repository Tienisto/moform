import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  void setTextAndFixCursor(String newText) {
    text = newText;
    selection = TextSelection.collapsed(offset: newText.length);
  }
}
