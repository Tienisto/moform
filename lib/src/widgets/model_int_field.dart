import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moform/src/text_field_builder.dart';

class IntField extends StatefulWidget {
  final int? value;
  final void Function(int) onChanged;
  final void Function(int)? onSubmitted;
  final TextStyle? style;
  final TextFieldBuilder? builder;
  final bool? enabled;
  final bool readOnly;

  const IntField({
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
      null => TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: widget.style,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          textInputAction: widget.onSubmitted == null
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: widget.onSubmitted == null ? null : (s) {
            final parsed = int.tryParse(s);
            if (parsed != null) {
              widget.onSubmitted!(parsed);
            }
          },
        ),
    };
  }
}

String _intToString(int? value) {
  return value?.toString() ?? '';
}
