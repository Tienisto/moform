import 'package:flutter/material.dart';
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
  int age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moform Example'),
      ),
      body: Column(
        children: [
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
        ],
      ),
    );
  }
}
