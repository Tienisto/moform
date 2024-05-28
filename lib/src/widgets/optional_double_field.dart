import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/widgets/base_number_field.dart';

/// A reactive text field representing an double value.
/// If the value is blank, it will be treated as null.
class OptionalDoubleField extends BaseNumberField<double?> {
  const OptionalDoubleField._({
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
    required super.enabled,
    required super.readOnly,
    required super.fallbackFormatter,
    required super.fallbackParser,
    required super.caster,
    required super.nullable,
  });

  factory OptionalDoubleField({
    Key? key,
    required double? value,
    NumberFormat? numberFormat,
    CustomNumberFormat<double>? customNumberFormat,
    required void Function(double?) onChanged,
    void Function(double?)? onSubmitted,
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
    bool readOnly = false,
  }) {
    return OptionalDoubleField._(
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
      readOnly: readOnly,
      fallbackFormatter: (BuildContext context, double? d) {
        if (d == null) {
          return '';
        }
        final locale = Localizations.localeOf(context).toLanguageTag();
        final sep = NumberFormat.decimalPattern(locale).symbols.DECIMAL_SEP;
        return d.toString().replaceAll('.', sep);
      },
      fallbackParser: (BuildContext context, String s) {
        final locale = Localizations.localeOf(context).toLanguageTag();
        final sep = NumberFormat.decimalPattern(locale).symbols.DECIMAL_SEP;
        return double.tryParse(s.replaceAll(sep, '.'));
      },
      caster: (num? n) => n?.toDouble(),
      nullable: true,
    );
  }
}
