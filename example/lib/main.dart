import 'package:flutter/material.dart';
import 'package:moform/moform.dart';

void main() {
  runApp(const MyApp());
}

class MyModel {
  final String email;
  final String password;
  final int age;

  MyModel({
    required this.email,
    required this.password,
    required this.age,
  });

  ModelConnector<String> get emailConnector => ModelConnector<String>.from(
        get: () => email,
        set: (value) => copyWith(email: value),
      );

  MyModel copyWith({
    String? email,
    String? password,
    int? age,
  }) {
    return MyModel(
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
    );
  }

  @override
  String toString() {
    return 'MyModel(email: $email, password: $password, age: $age)';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  MyModel model = MyModel(email: '', password: '', age: 0);

  @override
  Widget build(BuildContext context) {
    print('Model: $model');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moform Example'),
      ),
      body: Moform(
        model: model,
        child: Column(
          children: [
            StringField(
              value: model.email,
              onChanged: (value) {
                setState(() {
                  model = model.copyWith(email: value);
                });
              },
            ),
            StringField(
              value: model.password,
              onChanged: (value) {
                setState(() {
                  model = model.copyWith(password: value);
                });
              },
            ),
            StringField(
              value: model.email,
              onChanged: (value) {
                setState(() {
                  model = model.copyWith(email: value);
                });
              },
            ),
            StringField(
              value: model.email,
              onChanged: (value) {
                setState(() {
                  model = model.copyWith(email: value);
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
              value: model.age,
              onChanged: (value) {
                setState(() {
                  model = model.copyWith(age: value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
