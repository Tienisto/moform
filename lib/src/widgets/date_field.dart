import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/widgets/base_date_time_tield.dart';

/// A reactive text field representing a date value.
class DateField extends StatelessWidget {
  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// The format used to display the date.
  final DateFormat? dateFormat;

  final void Function(DateTime) onChanged;
  final FormFieldValidator<DateTime?>? validator;
  final InputDecoration? decoration;

  // alias for decoration
  final String? label;
  final String? hint;
  final String? prefixText;
  final String? suffixText;
  final Icon? icon;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  final TextStyle? style;
  final TextFieldBuilder? builder;
  final bool? enabled;

  const DateField({
    super.key,
    required this.value,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    required this.onChanged,
    this.validator,
    this.decoration,
    this.label,
    this.hint,
    this.prefixText,
    this.suffixText,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.builder,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDateTimeField(
      value: value,
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
      style: style,
      builder: builder,
      enabled: enabled,
      includeTime: false,
      formatter: _dateTimeToString,
    );
  }
}

String _dateTimeToString(
    BuildContext context, DateFormat? dateFormat, DateTime? value) {
  if (value == null) {
    return '';
  }

  if (dateFormat == null) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMd(locale).format(value);
  }

  return dateFormat.format(value);
}
