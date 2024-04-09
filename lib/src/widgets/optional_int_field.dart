import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/widgets/base_number_field.dart';
import 'package:moform/src/widgets/int_field.dart';

typedef OptionalIntFormatter = String Function(int?);

/// A reactive text field representing an integer value.
/// If the value is blank, it will be treated as null.
class OptionalIntField extends StatelessWidget {
  final int? value;

  /// Custom formatter for the integer value.
  final NumberFormat? numberFormat;

  /// Custom formatter for the integer value.
  /// Providing this will ignore [numberFormat].
  final OptionalIntFormatter? formatter;

  /// Custom parser for the integer value.
  /// Must be provided if [formatter] is provided.
  /// It should be the inverse of [formatter].
  final IntParser? parser;

  final void Function(int?) onChanged;
  final void Function(int?)? onSubmitted;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;

  // alias for decoration
  final String? label;
  final String? hint;
  final String? prefixText;
  final String? suffixText;
  final Icon? icon;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;

  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextFieldBuilder? builder;
  final bool? enabled;
  final bool readOnly;

  const OptionalIntField({
    super.key,
    required this.value,
    this.numberFormat,
    this.formatter,
    this.parser,
    required this.onChanged,
    this.onSubmitted,
    this.validator,
    this.decoration,
    this.label,
    this.hint,
    this.prefixText,
    this.suffixText,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.style,
    this.textInputAction,
    this.builder,
    this.enabled,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseNumberField<int?>(
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
      keyboardType: keyboardType,
      style: style,
      textInputAction: textInputAction,
      builder: builder,
      enabled: enabled,
      readOnly: readOnly,
      fallbackFormatter: (int? i) => i?.toString() ?? '',
      fallbackParser: (String s) => int.tryParse(s),
      caster: (num? n) => n?.toInt(),
      nullable: true,
    );
  }
}
