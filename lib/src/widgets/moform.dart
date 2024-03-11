import 'package:flutter/material.dart';

class Moform<T> extends StatefulWidget {
  final T model;
  final Widget child;

  const Moform({
    required this.model,
    required this.child,
    super.key,
  });

  @override
  State<Moform> createState() => _MoformState();
}

class _MoformState extends State<Moform> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: widget.child,
    );
  }
}
