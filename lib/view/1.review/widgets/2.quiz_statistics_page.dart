import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';
import 'package:studytools/model/appcolors.dart';

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
              style: const TextStyle(fontSize: 25, color: AppColors.dark),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Text(
              "Current Streak: ${controller.streak}",
              style: const TextStyle(fontSize: 25, color: AppColors.dark),
            ),
          ),
        ),
       SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Text(
              "Highest Streak: ${controller.dbController.statistics[0]['highest_correct_answers_streak']}",
              style: const TextStyle(fontSize: 25, color: AppColors.dark),
            ),
          ),
        ),
      ]),
    );
  }
}
