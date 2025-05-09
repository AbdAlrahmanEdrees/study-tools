import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/model/appcolors.dart';
import 'package:wordup/view/quizpage.dart';
import 'package:wordup/view/wordslistpage.dart';

class QuizzesPage extends StatelessWidget {
  const QuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: MaterialButton(
                  color: AppColors.secondColor,
                    onPressed: () {
                      Get.to(const QuizPage());
                    },
                    child: const Text("Take A Quiz")),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                child: MaterialButton(
                  color: AppColors.secondColor,
                    onPressed: () {
                      Get.to(WordsListPage());
                    },
                    child: const Text("See DB Words")),
              ),
            ]),
      ),
    );
  }
}
