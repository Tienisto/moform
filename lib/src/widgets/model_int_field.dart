import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moform/src/model/model_connector.dart';
import 'package:moform/src/model_field_builder.dart';

class IntField extends StatefulWidget {
  final ModelConnector<int> connector;
  final ModelFieldBuilder? builder;

  IntField({
    required int value,
    required void Function(int) onChanged,
    this.builder,
    super.key,
  }) : connector = ModelConnector<int>.from(
          get: () => value,
          set: onChanged,
        );

  const IntField.withConnector({
    required this.connector,
    this.builder,
    super.key,
  });

  @override
  State<IntField> createState() => _IntFieldState();
}

class _IntFieldState extends State<IntField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.connector.value.toString();
    _controller.addListener(() {
      final parsed = int.tryParse(_controller.text);
      if (parsed != null) {
        widget.connector.value = parsed;
      }
    });
  }

  @override
  void didUpdateWidget(IntField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.connector.value.toString() != _controller.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = widget.connector.value.toString();
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
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
    };
  }
}
