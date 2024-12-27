# Moform

[![pub package](https://img.shields.io/pub/v/moform.svg)](https://pub.dev/packages/moform)
![ci](https://github.com/Tienisto/moform/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Reactive, model-driven, and type-safe forms for Flutter without the overhead of managing a TextEditingController.

## Motivation

Similar to `Switch` and `Checkbox`, changing the `value` of a text field *should* automatically update the UI.
However, this requires a `TextEditingController` and a `TextFormField` to manage the state of the field.

Moform aims to be a very slim abstraction layer on top of `TextFormField`
with 3 distinct features:

- ✅ Reactive: Automatically update the UI when `value` changes.
- ✅ Type-safe: Different fields for different types (String, int, double, DateTime).
- ✅ Slim: Widgets look and behave like `TextFormField` with minimal overhead.

## Getting Started

### ➤ Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  moform: <version>
```

### ➤ Usage

In this example, we are using a `StringField` to manage the value of an email field.

Using a `StatefulWidget`:

```dart
class EmailField extends StatefulWidget {
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return StringField(
      value: _email,
      onChanged: (value) {
        setState(() => _email = value);
      },
    );
  }
}
```

Using [Riverpod](https://pub.dev/packages/riverpod):

```dart
final emailProvider = StateProvider<String>((ref) => '');

class EmailField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);

    return StringField(
      value: email,
      onChanged: (value) {
        ref.read(emailProvider.notifier).state = value;
      },
    );
  }
}
```

## Features

### ➤ Typed Fields

**String**

```dart
StringField(
  value: email,
  onChanged: (value) {
    setState(() => email = value);
  },
);
```

**Int**

```dart
IntField(
  value: age,
  onChanged: (value) {
    setState(() => age = value);
  },
);
```

**Double**

```dart
DoubleField(
  value: weight,
  onChanged: (value) {
    setState(() => weight = value);
  },
);
```

**DateTime**

```dart
DateTimeField(
  value: date,
  onChanged: (value) {
    setState(() => date = value);
  },
);
```

**DateTime (Date only)**

```dart
DateField(
  value: date,
  onChanged: (value) {
    setState(() => date = value);
  },
);
```

**TimeOfDay**

```dart
TimeField(
  value: time,
  onChanged: (value) {
    setState(() => time = value);
  },
);
```

### ➤ Nullable Fields

There are nullable versions of the fields above:

`OptionalStringField`, `OptionalIntField`, `OptionalDoubleField`.

These fields have `onChanged` callbacks that receive `String?`, `int?`, and `double?` respectively.

```dart
OptionalStringField(
  value: email,
  onChanged: (String? value) { // <-- null, when the field is empty
    setState(() => email = value);
  },
);
```

To clear a `DateTimeField`, `DateField`, or `TimeField`, add the `onCleared` callback:

```dart
DateTimeField(
  value: date,
  onChanged: (value) {
    setState(() => date = value);
  },
  onCleared: () {
    setState(() => date = null);
  },
);
```

### ➤ Custom Styles

Provide a custom widget with the `builder` parameter.

Be aware that parameters like `label` are ignored when using a custom widget.

```dart
StringField(
  value: email,
  onChanged: (value) {
    setState(() {
      email = value;
    });
  },
  builder: (context, controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Custom Field',
      ),
    );
  },
);
```

### ➤ Custom NumberFormat

Available in `IntField`, `DoubleField`, and their nullable versions.

```dart
IntField(
  value: age,
  numberFormat: NumberFormat.decimalPattern(),
  onChanged: (value) {
    setState(() => age = value);
  },
);
```

For more complex scenarios, you can provide a `customNumberFormat`.
Be aware, that the `parser` should be the exact inverse of the `formatter`.

```dart
IntField(
  value: age,
  customNumberFormat: CustomNumberFormat(
    formatter: (i) => i.toString(),
    parser: (s) => int.tryParse(s),
  ),
  onChanged: (value) {
    setState(() => age = value);
  },
);
```

### ➤ Clear Button

There is a convenience `onCleared` callback to clear the field.
If this callback is provided, a clear button will be displayed.
This parameter is ignored when `decoration` or `builder` is provided.

```dart
StringField(
  value: email,
  onChanged: (value) {
    setState(() => email = value);
  },
  onCleared: () {
    setState(() => email = '');
  },
);
```

## License

MIT License

Copyright (c) 2024 Tien Do Nam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
