import 'package:flutter/material.dart';

/// A builder for a text field.
typedef TextFieldBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
);

/// A builder for a text field with an [onTap] callback.
typedef TextFieldWithOnTapBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  void Function() onTap,
);
