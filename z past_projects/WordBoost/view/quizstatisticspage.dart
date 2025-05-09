import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/quizcontroller.dart';

class QuizStatisticsPage extends GetView<QuizController> {
  const QuizStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        SizedBox(
          height: 150,
          width: 200,
          child: Center(
            child: Text(
              "Accuracy: ${((controller.dbWords.length - controller.wrong.value) / controller.dbWords.length) * 100}%",
              style: const TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Text(
              "Current Streak: ${controller.streak}",
              style: const TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
        ),
       SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Text(
              "Highest Streak: ${controller.highestStreak}",
              style: const TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
        ),
      ]),
    );
  }
}
