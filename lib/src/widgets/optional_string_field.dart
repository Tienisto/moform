import 'package:flutter/material.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';
import 'package:moform/src/utils/strings_ext.dart';
import 'package:moform/src/utils/text_editing_controller_ext.dart';

/// A reactive text field representing a string value.
/// If the value is blank, it will be treated as null.
class OptionalStringField extends StatefulWidget {
  /// The current value of the field.
  final String? value;

  /// Called when the value changes.
  final void Function(String?) onChanged;

  /// Called when the user submits the value.
  final void Function(String?)? onSubmitted;

  /// Called when the user taps the field.
  final void Function()? onTap;

  final FormFieldValidator<String>? validator;

  /// The decoration of the text field.
  /// Some fields are obsolete when this is provided.
  final InputDecoration? decoration;

  // alias for decoration
  final String? label;
  final String? hint;
  final String? prefixText;
  final String? suffixText;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onCleared;
  final TextInputType? keyboardType;

  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;

  final String obscuringCharacter;
  final bool obscureText;

  /// Custom builder for the text field.
  /// Some fields are obsolete when using this builder.
  final TextFieldBuilder? builder;

  final bool? enabled;
  final bool autofocus;
  final bool readOnly;

  const OptionalStringField({
    super.key,
    required this.value,
    required this.onChanged,
    this.onSubmitted,
    this.onTap,
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
    this.keyboardType,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.builder,
    this.enabled,
    this.autofocus = false,
    this.readOnly = false,
  });

  @override
  State<OptionalStringField> createState() => _OptionalStringFieldState();
}

class _OptionalStringFieldState extends State<OptionalStringField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value ?? '';
    _controller.addListener(() {
      final controllerValue = _controller.text.digestNullable();
      if (controllerValue != widget.value) {
        widget.onChanged(controllerValue);
      }
    });
  }

  @override
  void didUpdateWidget(OptionalStringField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.setTextAndFixCursor(widget.value ?? '');
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
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
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
