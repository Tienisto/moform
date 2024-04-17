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
    required super.formatter,
    required super.parser,
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
    required super.textInputAction,
    required super.builder,
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
    String Function(int)? formatter,
    int? Function(String)? parser,
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
    TextInputAction? textInputAction,
    TextFieldBuilder? builder,
    bool? enabled,
    bool readOnly = false,
  }) {
    return IntField._(
      key: key,
      value: value,
      numberFormat: numberFormat,
      formatter: formatter,
      parser: parser,
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
      textInputAction: textInputAction,
      builder: builder,
      enabled: enabled,
      readOnly: readOnly,
      fallbackFormatter: (int i) => i.toString(),
      fallbackParser: (String s) => int.tryParse(s),
      caster: (num? n) => n?.toInt(),
      nullable: false,
    );
  }
}
