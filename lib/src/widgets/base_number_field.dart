import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

@internal
typedef NumberFormatter<T> = String Function(T);

@internal
typedef NumberParser<T> = T? Function(String);

final _doubleFilteringInput =
    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'));

@internal
class BaseNumberField<T> extends StatefulWidget {
  final T? value;

  /// Custom formatter for the integer value.
  final NumberFormat? numberFormat;

  /// Custom formatter for the integer value.
  /// Providing this will ignore [numberFormat].
  final NumberFormatter<T>? formatter;

  /// Custom parser for the integer value.
  /// Must be provided if [formatter] is provided.
  /// It should be the inverse of [formatter].
  final NumberParser<T>? parser;

  final void Function(T) onChanged;
  final void Function(T)? onSubmitted;
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

  final NumberFormatter<T> fallbackFormatter;
  final NumberParser<T> fallbackParser;
  final T? Function(num?) caster;

  const BaseNumberField({
    super.key,
    required this.value,
    required this.numberFormat,
    required this.formatter,
    required this.parser,
    required this.onChanged,
    required this.onSubmitted,
    required this.validator,
    required this.decoration,
    required this.label,
    required this.hint,
    required this.prefixText,
    required this.suffixText,
    required this.icon,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.keyboardType,
    required this.style,
    required this.textInputAction,
    required this.builder,
    required this.enabled,
    required this.readOnly,
    required this.fallbackFormatter,
    required this.fallbackParser,
    required this.caster,
  }) : assert(
            (formatter == null && parser == null) ||
                (formatter != null && parser != null),
            'formatter and parser must be provided together');

  @override
  State<BaseNumberField<T>> createState() => _BaseNumberFieldState();
}

class _BaseNumberFieldState<T> extends State<BaseNumberField<T>> {
  final TextEditingController _controller = TextEditingController();
  String? _lastInput;

  @override
  void initState() {
    super.initState();
    _controller.text = _numberToString<T>(
      widget.numberFormat,
      widget.formatter,
      widget.fallbackFormatter,
      widget.value,
    );
    _controller.addListener(() {
      final newInput = _controller.text;
      if (newInput == _lastInput) {
        return;
      }
      _lastInput = newInput;
      final T? parsed = widget.parser?.call(newInput) ??
          widget.caster(widget.numberFormat?.parse(newInput)) ??
          widget.fallbackParser(newInput);
      if (parsed != null && parsed != widget.value) {
        widget.onChanged(parsed);
      } else {
        if (T == double && (newInput.endsWith(',') || newInput.endsWith('.'))) {
          // do nothing, wait for the user to finish typing
          return;
        }

        // Reset the text to the last valid value.
        _controller.text = _numberToString<T>(
          widget.numberFormat,
          widget.formatter,
          widget.fallbackFormatter,
          widget.value,
        );
      }
    });
  }

  @override
  void didUpdateWidget(BaseNumberField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValue = _numberToString<T>(
      widget.numberFormat,
      widget.formatter,
      widget.fallbackFormatter,
      widget.value,
    );
    if (newValue != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = newValue;
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
          keyboardType: T == int
              ? TextInputType.number
              : const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
          inputFormatters: <TextInputFormatter>[
            if (T == int)
              FilteringTextInputFormatter.digitsOnly
            else if (T == double)
              _doubleFilteringInput,
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
                  final T? parsed = widget.parser?.call(_controller.text) ??
                      widget.caster(
                          widget.numberFormat?.parse(_controller.text)) ??
                      widget.fallbackParser(_controller.text);
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

String _numberToString<T>(
  NumberFormat? numberFormat,
  NumberFormatter<T>? formatter,
  NumberFormatter<T> fallbackFormatter,
  T? value,
) {
  if (value == null) {
    return '';
  }

  return formatter?.call(value) ??
      numberFormat?.format(value) ??
      fallbackFormatter(value);
}