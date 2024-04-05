import 'package:flutter/material.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

class StringField extends StatefulWidget {
  final String value;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
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
    this.keyboardType,
    this.style,
    this.textInputAction,
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
      widget.onChanged(_controller.text);
    });
  }

  @override
  void didUpdateWidget(StringField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.value;
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
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction ??
              (widget.onSubmitted == null
                  ? TextInputAction.done
                  : TextInputAction.next),
          onFieldSubmitted: widget.onSubmitted,
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
