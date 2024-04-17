import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

typedef DateTimeFormatter = String Function(
  BuildContext context,
  DateFormat? dateFormat,
  DateTime? value,
);

@internal
class BaseDateTimeField extends StatefulWidget {
  final DateTime? value;

  /// The initial date that the calendar picker should display
  /// when [value] is null.
  /// If null, defaults to the current date and time.
  final DateTime? suggestedDate;

  final DateTime? firstDate;
  final DateTime? lastDate;

  /// The format used to display the date and time.
  final DateFormat? dateFormat;

  final void Function(DateTime) onChanged;
  final void Function()? onDeleted;
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
  final TextFieldWithOnTapBuilder? builder;
  final bool? enabled;

  final bool includeTime;
  final DateTimeFormatter formatter;

  const BaseDateTimeField({
    required super.key,
    required this.value,
    required this.suggestedDate,
    required this.firstDate,
    required this.lastDate,
    required this.dateFormat,
    required this.onChanged,
    required this.onDeleted,
    required this.validator,
    required this.decoration,
    required this.label,
    required this.hint,
    required this.prefixText,
    required this.suffixText,
    required this.icon,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.style,
    required this.builder,
    required this.enabled,
    required this.includeTime,
    required this.formatter,
  });

  @override
  State<BaseDateTimeField> createState() => _BaseDateTimeFieldState();
}

class _BaseDateTimeFieldState extends State<BaseDateTimeField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(BaseDateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateFromWidget();
    }
  }

  void _updateFromWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.text = widget.formatter(
          context,
          widget.dateFormat,
          widget.value,
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
    final context = this.context;
    final date = await showDatePicker(
      context: context,
      initialDate: widget.value ?? widget.suggestedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (date == null || !context.mounted) {
      return;
    }

    TimeOfDay? time;
    if (widget.includeTime) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          widget.value ?? widget.suggestedDate ?? DateTime.now(),
        ),
      );

      if (time == null || !context.mounted) {
        return;
      }
    }

    widget.onChanged(DateTime(
      date.year,
      date.month,
      date.day,
      time?.hour ?? 0,
      time?.minute ?? 0,
    ));
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
            onDeleted: widget.onDeleted,
            hasInput: _controller.text.isNotEmpty,
            keyboardType: null,
          ),
        ),
    };
  }
}
