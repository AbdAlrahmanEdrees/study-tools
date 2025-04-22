import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/view/3.stats/1.statspage.dart';
import 'package:studytools/view/1.wordboost/1.wordboostpage.dart';
import 'package:studytools/view/2.pomodoro/1.pomodoropage.dart';

class HomeController extends GetxController {
  RxString title = "WordBoost".obs;
  RxInt index = 1.obs;
  Widget Page = const ReviewPage();
  bool backButtonVisibility = false;
  void bottomNavigation(int indx) {
    if (indx == index.value) {
      return;
    } else {
      switch (indx) {
        case 0:
          Page =  StatsPage();
          title.value = "Statistics";
        case 1:
          Page = const ReviewPage();
          title.value = "WordBoost";
        case 2:
          Page = const PomodoroPage();
          title.value = "Pomodoro";
      }
      index.value = indx;
      backButtonVisibility = false;
      update();
    }
  }

  // void goToTranslator() {
  //   Page = Translator();
  //   backButtonVisibility = true;
  //   update();
  // }
}
