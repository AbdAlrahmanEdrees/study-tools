import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  static const String routeName = '/statistics';

  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const int totalPomodoros = 20;
    const int totalMinutesFocused = 500;
    const int totalBreaks = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text('statistics'),
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: ListView(
    children: [
      TextField(
        controller: TextEditingController(text: 'To so far'),
        decoration: const InputDecoration(
          labelText: 'Task',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      TextField(
        controller: TextEditingController(text: '$totalPomodoros'),
        decoration: const InputDecoration(
          labelText: 'Total Pomodoros',
          labelStyle: TextStyle(fontSize: 20),
        ),
        style: const TextStyle(fontSize: 24),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: TextEditingController(text: 'Yesterday'),
        decoration: const InputDecoration(
          labelText: 'Date',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      TextField(
        controller: TextEditingController(text: '$totalMinutesFocused'),
        decoration: const InputDecoration(
          labelText: 'Total Minutes Focused',
          labelStyle: TextStyle(fontSize: 20),
        ),
        style: const TextStyle(fontSize: 24),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: TextEditingController(text: 'This month so far'),
        decoration: const InputDecoration(
          labelText: 'Time Period',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: TextEditingController(text: 'Last month'),
        decoration: const InputDecoration(
          labelText: 'Previous Time Period',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: TextEditingController(text: 'Total'),
        decoration: const InputDecoration(
          labelText: 'Summary',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: TextEditingController(text: '$totalBreaks'),
        decoration: const InputDecoration(
          labelText: 'Total Breaks',
          labelStyle: TextStyle(fontSize: 20),
        ),
        style: const TextStyle(fontSize: 24),
      ),
    ],
  ),
),

);
  }
}
