import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
extension TextEditingControllerExt on TextEditingController {
  void setTextAndFixCursor(String newText) {
    text = newText;
    selection = TextSelection.collapsed(offset: newText.length);
  }
}
