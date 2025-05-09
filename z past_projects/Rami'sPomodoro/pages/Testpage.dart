import 'package:flutter/material.dart';

class TestsPage extends StatelessWidget {
  static const String routeName = '/tests';

  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('Welcome to the Tests Page!', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
