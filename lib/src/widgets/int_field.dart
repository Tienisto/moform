import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/widgets/base_number_field.dart';

/// A reactive text field representing an integer value.
class IntField extends BaseNumberField<int> {
  const IntField._({
    required super.key,
    required super.value,
    required super.numberFormat,
    required super.customNumberFormat,
    required super.onChanged,
    required super.onSubmitted,
    required super.validator,
    required super.decoration,
    required super.label,
    required super.hint,
    required super.prefixText,
    required super.suffixText,
    required super.icon,
    required super.prefixIcon,
    required super.suffixIcon,
    required super.onCleared,
    required super.keyboardType,
    required super.style,
    required super.strutStyle,
    required super.textAlign,
    required super.textAlignVertical,
    required super.textInputAction,
    required super.builder,
    required super.autofocus,
    required super.enabled,
    required super.readOnly,
    required super.fallbackFormatter,
    required super.fallbackParser,
    required super.caster,
    required super.nullable,
  });

  factory IntField({
    Key? key,
    required int? value,
    NumberFormat? numberFormat,
    CustomNumberFormat<int>? customNumberFormat,
    required void Function(int) onChanged,
    void Function(int)? onSubmitted,
    FormFieldValidator<String>? validator,
    InputDecoration? decoration,
    String? label,
    String? hint,
    String? prefixText,
    String? suffixText,
    Icon? icon,
    Icon? prefixIcon,
    Icon? suffixIcon,
    void Function()? onCleared,
    TextInputType? keyboardType,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextInputAction? textInputAction,
    TextFieldBuilder? builder,
    bool? enabled,
    bool autofocus = false,
    bool readOnly = false,
  }) {
    return IntField._(
      key: key,
      value: value,
      numberFormat: numberFormat,
      customNumberFormat: customNumberFormat,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      decoration: decoration,
      label: label,
      hint: hint,
      prefixText: prefixText,
      suffixText: suffixText,
      icon: icon,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onCleared: onCleared,
      keyboardType: keyboardType,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textInputAction: textInputAction,
      builder: builder,
      enabled: enabled,
      autofocus: autofocus,
      readOnly: readOnly,
      fallbackFormatter: (BuildContext context, int i) => i.toString(),
      fallbackParser: (BuildContext context, String s) => int.tryParse(s),
      caster: (num? n) => n?.toInt(),
      nullable: false,
    );
  }
}
