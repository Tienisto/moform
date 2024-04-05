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
StringField(
  value: email,
  onChanged: (value) {
    setState(() => email = value);
  },
);
```

Using [Riverpod](https://pub.dev/packages/riverpod):

```dart
final emailProvider = StateProvider<String>((ref) => '');

StringField(
  value: ref.watch(emailProvider).state,
  onChanged: (value) {
    ref.read(emailProvider).state = value;
  },
);
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

Use `builder` to customize provide a custom field widget.

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