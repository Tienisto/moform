import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

typedef DateTimeFormatter = String Function(
  BuildContext context,
  DateFormat? dateFormat,
  TimeOfDay? value,
);

/// A reactive text field representing a time value.
class TimeField extends StatefulWidget {
  final TimeOfDay? value;

  /// The initial time that the time picker should display
  /// when [value] is null.
  final TimeOfDay? suggestedTime;

  /// The format used to display the date and time.
  final DateFormat? dateFormat;

  final void Function(TimeOfDay) onChanged;
  final FormFieldValidator<TimeOfDay?>? validator;
  final InputDecoration? decoration;

  // alias for decoration
  final String? label;
  final String? hint;
  final String? prefixText;
  final String? suffixText;
  final Icon? icon;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final void Function()? onCleared;

  final TextStyle? style;
  final TextFieldWithOnTapBuilder? builder;
  final bool? enabled;

  const TimeField({
    super.key,
    required this.value,
    this.suggestedTime,
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
    this.onCleared,
    this.style,
    this.builder,
    this.enabled,
  });

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(TimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateFromWidget();
    }
  }

  void _updateFromWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final value = widget.value;
        _controller.text = _dateTimeToString(
          context,
          widget.dateFormat,
          value == null ? null : DateTime(1900, 1, 1, value.hour, value.minute),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    final time = await showTimePicker(
      context: context,
      initialTime: widget.value ?? widget.suggestedTime ?? TimeOfDay.now(),
    );

    if (time == null || !context.mounted) {
      return;
    }

    widget.onChanged(time);
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.builder) {
      TextFieldWithOnTapBuilder builder => builder(
          context,
          _controller,
          _onTap,
        ),
      null => TextFormField(
          controller: _controller,
          onTap: _onTap,
          validator: widget.validator == null
              ? null
              : (_) {
                  return widget.validator!(widget.value);
                },
          style: widget.style,
          enabled: widget.enabled,
          readOnly: true,
          // ignore: invalid_use_of_internal_member
          decoration: buildInputDecoration(
            context: context,
            decoration: widget.decoration,
            label: widget.label,
            hint: widget.hint,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            icon: widget.icon,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            onCleared: widget.onCleared,
            hasInput: _controller.text.isNotEmpty,
            keyboardType: null,
          ),
        ),
    };
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
    return DateFormat.Hm(locale).format(value);
  }

  return dateFormat.format(value);
}
