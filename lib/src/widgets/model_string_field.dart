import 'package:flutter/material.dart';
import 'package:moform/src/model/model_connector.dart';
import 'package:moform/src/model_field_builder.dart';

class StringField extends StatefulWidget {
  final ModelConnector<String> connector;
  final ModelFieldBuilder? builder;

  StringField({
    required String value,
    required void Function(String) onChanged,
    this.builder,
    super.key,
  }) : connector = ModelConnector<String>.from(
          get: () => value,
          set: onChanged,
        );

  const StringField.withConnector({
    required this.connector,
    this.builder,
    super.key,
  });

  @override
  State<StringField> createState() => _StringFieldState();
}

class _StringFieldState extends State<StringField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.connector.value;
    _controller.addListener(() {
      widget.connector.value = _controller.text;
    });
  }

  @override
  void didUpdateWidget(StringField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.connector.value != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.connector.value;
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
      ModelFieldBuilder builder => builder(context, _controller),
      null => TextField(
        controller: _controller,
      ),
    };
  }
}
