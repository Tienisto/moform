import 'package:flutter/material.dart';
import 'package:moform/src/text_field_builder.dart';

class StringField extends StatefulWidget {
  final String value;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final TextStyle? style;
  final TextFieldBuilder? builder;
  final bool? enabled;
  final bool readOnly;

  const StringField({
    super.key,
    required this.value,
    required this.onChanged,
    this.onSubmitted,
    this.style,
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
      null => TextField(
          controller: _controller,
          style: widget.style,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          textInputAction: widget.onSubmitted == null
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: widget.onSubmitted,
        ),
    };
  }
}
