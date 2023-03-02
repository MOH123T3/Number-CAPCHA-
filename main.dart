import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NumberCapcha/Capcha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Number Capcha in Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              onPressed: () async {
                var isValid = await FlutterNumberCaptcha.show(
                  context,
                  titleText: 'Enter correct number',
                  placeholderText: 'Enter Number',
                  checkCaption: 'Check',
                  accentColor: Colors.purple,
                  invalidText: 'Invalid number',
                );
                if (isValid == true) {}
              },
              child: Text("Show"))),
    );
  }
}
