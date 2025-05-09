import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/view/homepage_levels.dart';
import 'package:wordup/view/homepage_quizzes.dart';

class HomeController extends GetxController {
  RxString title = "Stories Level".obs;
  RxInt index = 0.obs;
  Widget Page = Levels();
  void goQuiz() {}
  void changePage(int indx) {
    if (indx == index.value) {
      return;
    } else {
      if (title.value == "Stories Level") {
        title.value = "Quiz";
        index.value = 1;
        Page = const QuizzesPage();
      } else {
        title.value = "Stories Level";
        index.value = 0;
        Page = Levels();
      }
      update();
    }
  }
}
