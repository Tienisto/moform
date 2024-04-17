import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:moform/moform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // locale: const Locale('de', 'DE'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = '';
  String password = '';
  String? optionalEmail;
  int age = 0;
  int? optionalAge;
  double height = 0;
  double? weight = 0;
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moform Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text('Strings', style: Theme.of(context).textTheme.titleLarge),
          StringField(
            value: email,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          StringField(
            value: password,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          StringField(
            value: email,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            onCleared: () {
              setState(() {
                email = '';
              });
            },
          ),
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
          ),
          OptionalStringField(
            value: optionalEmail,
            onChanged: (value) {
              setState(() {
                optionalEmail = value;
              });
            },
          ),
          Text('Optional Email: $optionalEmail'),
          const SizedBox(height: 16),
          Text('Integers', style: Theme.of(context).textTheme.titleLarge),
          IntField(
            value: age,
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
          ),
          IntField(
            value: age,
            onChanged: (value) {
              setState(() {
                age = value;
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
          ),
          IntField(
            label: 'Custom NumberFormat',
            value: age,
            numberFormat: NumberFormat.decimalPattern(),
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
          ),
          IntField(
            label: 'Custom Formatter (2x)',
            value: age,
            formatter: (i) => (i * 2).toString(),
            parser: (s) => int.parse(s) ~/ 2,
            onChanged: (value) {
              setState(() {
                age = value;
              });
            },
          ),
          OptionalIntField(
            label: 'Optional Age',
            value: optionalAge,
            onChanged: (value) {
              setState(() {
                optionalAge = value;
              });
            },
          ),
          Text('Optional Age: $optionalAge'),
          const SizedBox(height: 16),
          Text('Doubles', style: Theme.of(context).textTheme.titleLarge),
          DoubleField(
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
          DoubleField(
            label: 'Custom NumberFormat',
            value: height,
            numberFormat: NumberFormat.decimalPattern(),
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
          OptionalDoubleField(
            value: weight,
            onChanged: (value) {
              setState(() {
                weight = value;
              });
            },
          ),
          Text('Weight: $weight'),
          const SizedBox(height: 16),
          Text('Date and Time', style: Theme.of(context).textTheme.titleLarge),
          DateField(
            label: 'Date',
            value: date,
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
            onCleared: () {
              setState(() {
                date = null;
              });
            },
          ),
          DateTimeField(
            label: 'Date Time',
            value: date,
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
          ),
          DateTimeField(
            label: 'Custom Date Time',
            value: date,
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
            builder: (context, controller, onTap) {
              return TextField(
                controller: controller,
                onTap: onTap,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Custom Field',
                ),
              );
            },
          ),
          TimeField(
            label: 'Time',
            value: time,
            onChanged: (value) {
              setState(() {
                time = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
