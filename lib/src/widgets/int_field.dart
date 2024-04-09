import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

typedef IntFormatter = String Function(int);
typedef IntParser = int? Function(String);

/// A reactive text field representing an integer value.
class IntField extends StatefulWidget {
  final int? value;

  /// Custom formatter for the integer value.
  final NumberFormat? numberFormat;

  /// Custom formatter for the integer value.
  /// Providing this will ignore [numberFormat].
  final IntFormatter? formatter;

  /// Custom parser for the integer value.
  /// Must be provided if [formatter] is provided.
  /// It should be the inverse of [formatter].
  final IntParser? parser;

  final void Function(int) onChanged;
  final void Function(int)? onSubmitted;
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

  const IntField({
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
  }) : assert((formatter == null && parser == null) ||
            (formatter != null && parser != null), 'formatter and parser must be provided together');

  @override
  State<IntField> createState() => _IntFieldState();
}

class _IntFieldState extends State<IntField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        _intToString(widget.numberFormat, widget.formatter, widget.value);
    _controller.addListener(() {
      final parsed = widget.parser?.call(_controller.text) ??
          widget.numberFormat?.parse(_controller.text).toInt() ??
          int.tryParse(_controller.text);
      if (parsed != null) {
        widget.onChanged(parsed);
      } else {
        // Reset the text to the last valid value.
        _controller.text =
            _intToString(widget.numberFormat, widget.formatter, widget.value);
      }
    });
  }

  @override
  void didUpdateWidget(IntField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_intToString(widget.numberFormat, widget.formatter, widget.value) !=
        _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text =
              _intToString(widget.numberFormat, widget.formatter, widget.value);
          _controller.selection =
              TextSelection.collapsed(offset: _controller.text.length);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.builder) {
      TextFieldBuilder builder => builder(context, _controller),
      null => TextFormField(
          controller: _controller,
          validator: widget.validator,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: widget.style,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction ??
              (widget.onSubmitted == null
                  ? TextInputAction.done
                  : TextInputAction.next),
          onFieldSubmitted: widget.onSubmitted == null
              ? null
              : (s) {
                  final parsed = int.tryParse(s);
                  if (parsed != null) {
                    widget.onSubmitted!(parsed);
                  }
                },
          decoration: buildInputDecoration(
            decoration: widget.decoration,
            label: widget.label,
            hint: widget.hint,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            icon: widget.icon,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            keyboardType: widget.keyboardType,
          ),
        ),
    };
  }
}

String _intToString(
  NumberFormat? numberFormat,
  IntFormatter? formatter,
  int? value,
) {
  if (value == null) {
    return '';
  }

  return formatter?.call(value) ??
      numberFormat?.format(value) ??
      value.toString();
}
