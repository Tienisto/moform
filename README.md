# Moform

Reactive, model-driven, and type-safe forms for Flutter without the overhead of managing a TextEditingController.

## Getting Started

### ➤ Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
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

### ➤ Custom Styles

Use `builder` to provide a custom field widget.

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