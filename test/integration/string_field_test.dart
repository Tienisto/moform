import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moform/moform.dart';

void main() {
  testWidgets('Should render initial value', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: _ValueWidget('Hello123'),
      ),
    );

    expect(find.text('Hello123'), findsOneWidget);
  });

  testWidgets('Should rerender on external change', (tester) async {
    final notifier = _Notifier('Initial State');

    await tester.pumpWidget(
      MaterialApp(home: _NotifierWidget(notifier)),
    );

    expect(find.text('Initial State'), findsOneWidget);

    notifier.value = 'New State';

    await tester.pump();

    expect(find.text('New State'), findsOneWidget);
  });

  testWidgets('Should rerender on internal change', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: _ValueWidget('Initial State'),
      ),
    );

    await tester.enterText(find.byType(TextField), 'New State');

    await tester.pump();

    expect(find.text('New State'), findsOneWidget);
  });

  testWidgets('Should emit correct onChanged value', (tester) async {
    final notifier = _Notifier('Initial State');

    await tester.pumpWidget(
      MaterialApp(home: _NotifierWidget(notifier)),
    );

    await tester.enterText(find.byType(TextField), 'New State');

    await tester.pump();

    expect(find.text('New State'), findsOneWidget);
    expect(notifier.value, 'New State');
  });
}

class _ValueWidget extends StatelessWidget {
  final String value;

  const _ValueWidget(this.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StringField(
        value: value,
        onChanged: (_) {},
      ),
    );
  }
}

class _NotifierWidget extends StatelessWidget {
  final _Notifier notifier;

  const _NotifierWidget(this.notifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: notifier,
        builder: (context, child) {
          return StringField(
            value: notifier.value,
            onChanged: (s) {
              notifier.value = s;
            },
          );
        },
      ),
    );
  }
}

class _Notifier extends ValueNotifier<String> {
  _Notifier(super.value);
}
