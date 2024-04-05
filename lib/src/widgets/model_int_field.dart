import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moform/src/text_field_builder.dart';
import 'package:moform/src/utils/input_decoration_builder.dart';

class IntField extends StatefulWidget {
  final int? value;
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
  State<IntField> createState() => _IntFieldState();
}

class _IntFieldState extends State<IntField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _intToString(widget.value);
    _controller.addListener(() {
      final parsed = int.tryParse(_controller.text);
      if (parsed != null) {
        widget.onChanged(parsed);
      } else {
        // Reset the text to the last valid value.
        _controller.text = _intToString(widget.value);
      }
    });
  }

  @override
  void didUpdateWidget(IntField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_intToString(widget.value) != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.value.toString();
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

String _intToString(int? value) {
  return value?.toString() ?? '';
}
