import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/widgets/base_date_time_tield.dart';

/// A reactive text field representing a date value.
class DateField extends BaseDateTimeField {
  const DateField._({
    required super.key,
    required super.value,
    required super.suggestedDate,
    required super.firstDate,
    required super.lastDate,
    required super.dateFormat,
    required super.onChanged,
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
    required super.style,
    required super.builder,
    required super.enabled,
    required super.includeTime,
    required super.formatter,
  });

  factory DateField({
    Key? key,
    required DateTime? value,
    DateTime? suggestedDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? dateFormat,
    required void Function(DateTime) onChanged,
    FormFieldValidator<DateTime?>? validator,
    InputDecoration? decoration,
    String? label,
    String? hint,
    String? prefixText,
    String? suffixText,
    Icon? icon,
    Icon? prefixIcon,
    Icon? suffixIcon,
    void Function()? onCleared,
    TextStyle? style,
    TextFieldWithOnTapBuilder? builder,
    bool? enabled,
  }) {
    return DateField._(
      key: key,
      value: value,
      suggestedDate: suggestedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      dateFormat: dateFormat,
      onChanged: onChanged,
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
      style: style,
      builder: builder,
      enabled: enabled,
      includeTime: false,
      formatter: _dateTimeToString,
    );
  }
}

String _dateTimeToString(
  BuildContext context,
  DateFormat? dateFormat,
  DateTime? value,
) {
  if (value == null) {
    return '';
  }

  if (dateFormat == null) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMd(locale).format(value);
  }

  return dateFormat.format(value);
}
