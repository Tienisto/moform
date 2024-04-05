# Moform

Reactive, model-driven, and type-safe forms for Flutter.

## Getting Started

### ➤ Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  moform: <version>
```

### ➤ Usage

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