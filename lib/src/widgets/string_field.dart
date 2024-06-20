import 'package:flutter/material.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';
import 'package:moform/src/utils/text_editing_controller_ext.dart';

/// A reactive text field representing a string value.
class StringField extends StatefulWidget {
  /// The current value of the field.
  final String value;

  /// Called when the value changes.
  final void Function(String) onChanged;

  /// Called when the user submits the value.
  final void Function(String)? onSubmitted;
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

  final String obscuringCharacter;
  final bool obscureText;

  /// Custom builder for the text field.
  /// Some fields are obsolete when using this builder.
  final TextFieldBuilder? builder;

  final bool? enabled;
  final bool readOnly;

  const StringField({
    super.key,
    required this.value,
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
    this.readOnly = false,
  });

  @override
  State<StringField> createState() => _StringFieldState();
}

class _StringFieldState extends State<StringField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
    _controller.addListener(() {
      if (_controller.text != widget.value) {
        widget.onChanged(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(StringField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.setTextAndFixCursor(widget.value);
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
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction ??
              (widget.onSubmitted == null
                  ? TextInputAction.done
                  : TextInputAction.next),
          onFieldSubmitted: widget.onSubmitted,
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
