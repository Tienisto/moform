import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
InputDecoration? buildInputDecoration({
  required BuildContext context,
  required InputDecoration? decoration,
  required String? label,
  required String? hint,
  required String? prefixText,
  required String? suffixText,
  required Icon? icon,
  required Icon? prefixIcon,
  required Icon? suffixIcon,
  required void Function()? onDeleted,
  required bool hasInput,
  required TextInputType? keyboardType,
}) {
  if (decoration != null) {
    return decoration;
  }
  if (label == null &&
      hint == null &&
      prefixText == null &&
      suffixText == null &&
      icon == null &&
      prefixIcon == null &&
      suffixIcon == null &&
      onDeleted == null &&
      keyboardType == null) {
    return null;
  }
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixText: prefixText,
    suffixText: suffixText,
    icon: icon,
    prefixIcon: prefixIcon,
    suffixIcon: hasInput && onDeleted != null
        ? Tooltip(
            message: MaterialLocalizations.of(context).deleteButtonTooltip,
            child: IconButton(
              icon: suffixIcon ?? const Icon(Icons.clear),
              onPressed: onDeleted,
            ),
          )
        : suffixIcon,
  );
}
