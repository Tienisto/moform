import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/first_frame_callback.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';
import 'package:moform/src/utils/number_format_ext.dart';
import 'package:moform/src/utils/text_editing_controller_ext.dart';
import 'package:moform/src/widgets/double_field.dart';
import 'package:moform/src/widgets/int_field.dart';
import 'package:moform/src/widgets/optional_double_field.dart';
import 'package:moform/src/widgets/optional_int_field.dart';

/// Custom formatter and parser for [T].
/// Used for [int] and [double] fields.
class CustomNumberFormat<T> {
  /// Custom formatter for the integer / double value.
  final NumberFormatter<T> formatter;

  /// Custom parser for the integer / double value.
  /// It should be the inverse of [formatter].
  /// May return null if the input is invalid.
  final NumberParser<T> parser;

  const CustomNumberFormat({
    required this.formatter,
    required this.parser,
  });
}

@internal
typedef NumberFormatter<T> = String Function(T);

@internal
typedef NumberParser<T> = T? Function(String);

@internal
typedef NumberFormatterWithContext<T> = String Function(
  BuildContext context,
  T value,
);

@internal
typedef NumberParserWithContext<T> = T? Function(
  BuildContext context,
  String value,
);

final _doubleFilteringInput =
    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'));

/// Superclass for [IntField], [DoubleField], [OptionalIntField], and
/// [OptionalDoubleField].
@internal
class BaseNumberField<T extends num?> extends StatefulWidget {
  /// The current value of the field.
  final T? value;

  /// Custom formatter for the integer value.
  final NumberFormat? numberFormat;

  /// Custom formatter for the integer value.
  /// Providing this will ignore [numberFormat].
  final CustomNumberFormat<T>? customNumberFormat;

  /// Called when the value changes.
  final void Function(T) onChanged;

  /// Called when the user submits the value.
  final void Function(T)? onSubmitted;
  final FormFieldValidator<String>? validator;

  /// The decoration of the text field.
  /// Some fields are obsolete when this is provided.
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
  final TextInputType? keyboardType;

  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final TextFieldBuilder? builder;
  final bool? enabled;
  final bool autofocus;
  final bool readOnly;

  final NumberFormatterWithContext<T> fallbackFormatter;
  final NumberParserWithContext<T> fallbackParser;
  final T? Function(num?) caster;
  final bool nullable;

  const BaseNumberField({
    required super.key,
    required this.value,
    required this.numberFormat,
    required this.customNumberFormat,
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
    required this.onCleared,
    required this.keyboardType,
    required this.style,
    required this.strutStyle,
    required this.textAlign,
    required this.textAlignVertical,
    required this.textInputAction,
    required this.builder,
    required this.enabled,
    required this.autofocus,
    required this.readOnly,
    required this.fallbackFormatter,
    required this.fallbackParser,
    required this.caster,
    required this.nullable,
  });

  @override
  State<BaseNumberField<T>> createState() => _BaseNumberFieldState();
}

class _BaseNumberFieldState<T extends num?> extends State<BaseNumberField<T>>
    with FirstFrameCallback {
  final TextEditingController _controller = TextEditingController();
  String? _lastInput;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newInput = _controller.text;
      if (newInput == _lastInput) {
        return;
      }
      _lastInput = newInput;
      final T? parsed = widget.customNumberFormat?.parser.call(newInput) ??
          widget.caster(widget.numberFormat?.parseOrNull(newInput)) ??
          widget.fallbackParser(context, newInput);
      if (parsed == widget.value) {
        return;
      }

      if (parsed == null) {
        if (widget.nullable && newInput.isEmpty) {
          widget.onChanged(null as T);
          return;
        }

        if (T == double && (newInput.endsWith(',') || newInput.endsWith('.'))) {
          // do nothing, wait for the user to finish typing
          return;
        }

        // Reset the text to the last valid value.
        if (!mounted) {
          return;
        }
        _controller.setTextAndFixCursor(_numberToString<T>(
          context,
          widget.numberFormat,
          widget.customNumberFormat?.formatter,
          widget.fallbackFormatter,
          widget.value,
        ));
        return;
      }

      widget.onChanged(parsed);
    });
  }

  @override
  void didUpdateWidget(BaseNumberField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValue = _numberToString<T>(
      context,
      widget.numberFormat,
      widget.customNumberFormat?.formatter,
      widget.fallbackFormatter,
      widget.value,
    );
    if (newValue != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _controller.setTextAndFixCursor(newValue);
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
    onFirstFrame(() {
      _controller.text = _numberToString<T>(
        context,
        widget.numberFormat,
        widget.customNumberFormat?.formatter,
        widget.fallbackFormatter,
        widget.value,
      );
    });

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
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction ??
              (widget.onSubmitted == null
                  ? TextInputAction.done
                  : TextInputAction.next),
          onFieldSubmitted: widget.onSubmitted == null
              ? null
              : (s) {
                  final T? parsed = widget.customNumberFormat?.parser
                          .call(_controller.text) ??
                      widget.caster(
                          widget.numberFormat?.parse(_controller.text)) ??
                      widget.fallbackParser(context, _controller.text);
                  if (parsed != null) {
                    widget.onSubmitted!(parsed);
                  }
                },
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
            keyboardType: widget.keyboardType,
          ),
        ),
    };
  }
}

String _numberToString<T>(
  BuildContext context,
  NumberFormat? numberFormat,
  NumberFormatter<T>? formatter,
  NumberFormatterWithContext<T> fallbackFormatter,
  T? value,
) {
  if (value == null) {
    return '';
  }

  return formatter?.call(value) ??
      numberFormat?.format(value) ??
      fallbackFormatter(context, value);
}
