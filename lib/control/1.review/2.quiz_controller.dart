import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/1.wordboost/widgets/1.quiz_buttons_page.dart';
import 'package:studytools/view/1.wordboost/widgets/2.quiz_statistics_page.dart';

//NOTE: you will see en and ar with variables names, while the same variables also
//serve the german quiz, that's because we first created only for english-arabic words quizzes
//and later we added the german-english words and quizzes
class QuizController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DbController dbController = Get.put(DbController());
  Timer? timer;
  // bool _flag = true; // for mutual exclusion
  // int timerDuration = 3;
  int enChoice = -1, arChoice = -1;
  bool takeQuiz = false;
  int indx = 0; // we will use it as a pointer on the dbWords
  RxList enButtonsVisibility = [true, true, true, true, true].obs;
  RxList arButtonsVisibility = [true, true, true, true, true].obs;
  RxList<Color> enColors = [
    AppColors.secondColor,
    // Colors.green,
    AppColors.secondColor,
    AppColors.secondColor,
    AppColors.secondColor,
    AppColors.secondColor
  ].obs;
  RxList<Color> arColors = [
    AppColors.secondColor,
    AppColors.secondColor,
    AppColors.secondColor,
    AppColors.secondColor,
    AppColors.secondColor
  ].obs;
  late List<Map> dbWords;
  RxList<String> enShown =
      ["", "", "", "", ""].obs; //the words that will be shown
  RxList arShown = ["", "", "", "", ""].obs; //after the animation
  final List<String> _enWords = [
    "",
    "",
    "",
    "",
    ""
  ]; //for the initButtons() and timer
  final List<String> _arWords = ["", "", "", "", ""]; //to set up within them
  int i = 0; //pointer to the list of dbWords
  // late RxList<Map> leftWords;
  // late RxList<Map> rightWords;
  Map<int, int> correctAnswers = {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
  };

  List<int> enAvailable = [0, 1, 2, 3, 4];
  //the quiz left/right slots that still
  List<int> arAvailable = [0, 1, 2, 3, 4]; //have no word assigned to it or
  //gussed correctly
  int _countDown = 5;
  Widget quizPage = const QuizButtonsPage();
  // late AnimationController animationController;
  // late Animation<Color?> animation;

  ///////////////////////////////////////////
  ///          quiz statistics variables    ///
  RxInt correct = 0.obs;
  RxInt wrong = 0.obs;
  RxInt streak = 0.obs;
  late int highestStreak;
  ///////////////////////////////////////////

  @override
  void onInit() {
    dbWords = dbController.words;
    highestStreak =
        dbController.statistics[0]['highest_correct_answers_streak'];
    initButtons();
    firstFiveInite();
    // if (dbWords.length < 5) {
    //   print("NO Enough Words");
    //   return;
    // }
    ////update();

    _startTimer();
    super.onInit();
  }

  void _startTimer() {
    timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => initButtons());
    // It will call the initButtons function every 3 seconds
    //as long as there is an instance of this controller in the memory

    // dbController.pomodoroSettings.listen((p0) {
    //   //like this we ensure that the reset function is called after the thread
    //   //that is updating the database has finished updating.
    //   reset();
    // });
  }

  void initButtons() {
    for (int i = enAvailable.length;
        i > 0;
        // && indx < dbWords.length;
        indx++,
        i--) {
      arAvailable.shuffle();
      enAvailable.shuffle();
      if (indx < dbWords.length) {
        _enWords[enAvailable[0]] = dbWords[indx]['word'];
        _arWords[arAvailable[0]] = dbWords[indx]['translation'];
        // enColors[enAvailable[0]] = AppColors.secondColor;
        // arColors[arAvailable[0]] = AppColors.secondColor;
        // enButtonsVisibility[enAvailable[0]] = true;
        // arButtonsVisibility[arAvailable[0]] = true;
        correctAnswers[enAvailable[0]] = arAvailable[0];
      } else {
        _enWords[enAvailable[0]] = "";
        _arWords[arAvailable[0]] = "";
      }
      arAvailable.remove(arAvailable[0]);
      enAvailable.remove(enAvailable[0]);
    }
  }

  void firstFiveInite() {
    for (int i = 0; i < 5; i++) {
      enShown[i] = _enWords[i];
      arShown[i] = _arWords[i];
    }
  }

  void chooseEng(int buttonIndx) {
    if (enAvailable.contains(buttonIndx)) return; //can not choose it again
    if (enChoice >= 0) {
      //
      if (buttonIndx == enChoice) {
        enColors[enChoice] = AppColors.secondColor;
        enChoice = -1;
      } else if (buttonIndx != enChoice) {
        enColors[enChoice] = AppColors.secondColor;
        enColors[buttonIndx] = Colors.blue;
        enChoice = buttonIndx;
      }
    } else {
      enChoice = buttonIndx;
      if (arChoice >= 0) {
        if (!takeQuiz) {
          takeQuiz = true;
          dbController.numberOfQuizzesPlusOne();
        }
        checkAnswer();
      } else {
        enColors[buttonIndx] = Colors.blue;
      }
    }
  }

  void chooseAr(int buttonIndx) {
    if (arAvailable.contains(buttonIndx)) return; //can not choose it again
    if (arChoice >= 0) {
      if (buttonIndx == arChoice) {
        arColors[arChoice] = AppColors.secondColor;
        arChoice = -1;
      } else if (buttonIndx != enChoice) {
        arColors[arChoice] = AppColors.secondColor;
        arColors[buttonIndx] = Colors.blue;
        arChoice = buttonIndx;
      }
    } else {
      arChoice = buttonIndx;
      if (enChoice >= 0) {
        checkAnswer();
      } else {
        arColors[buttonIndx] = Colors.blue;
      }
    }
  }

  void checkAnswer() async {
    if (correctAnswers[enChoice] == arChoice) {
      enAvailable.add(enChoice); // we can remove this word now and put ..
      arAvailable.add(arChoice); // a new one
      enColors[enChoice] = Colors.green;
      arColors[arChoice] = Colors.green;
      dbController.wordPlusReview(enShown[enChoice]);
      correct.value++;
      streak.value++;
      coolDownTrue(enChoice, arChoice);
      // initButtons();
    } else {
      enColors[enChoice] = Colors.red;
      arColors[arChoice] = Colors.red;
      streak.value = 0;
      wrong.value++;
      coolDownFalse(enChoice, arChoice);
    }
    enChoice = -1;
    arChoice = -1;
  }

  void coolDownTrue(int en, int ar) async {
    // _startTimer();
    await Future.delayed(const Duration(milliseconds: 1500), () {
      enButtonsVisibility[en] = false;
      arButtonsVisibility[ar] = false;
      Future.delayed(const Duration(seconds: 2), () {
        print(enShown[en]);
        print(_enWords[en]);
        // while (enShown[en] == _enWords[en]) {
        //   //wait until the timer refreshes the _enWords and _arWords
        //   print("s");
        // }
        if (_enWords[en] != "") {
          enShown[en] = _enWords[en];
          arShown[ar] = _arWords[ar];
          enButtonsVisibility[en] = true;
          arButtonsVisibility[ar] = true;
          enColors[en] = AppColors.secondColor;
          arColors[ar] = AppColors.secondColor;
        } else if (indx >= dbWords.length) {
          _countDown--;
          print("\n\nyes $_countDown\n\n");
          if (_countDown == 0) {
            if (streak.value > highestStreak) {
              dbController.editHighestStreak(streak.value);
              highestStreak = streak.value;
              print("new H S added\n\n");
            }
            quizPage = const QuizStatisticsPage();
            update();
          }
        }
      });
    });
    // initButtons();
  }

  void coolDownFalse(int en, int ar) async {
    await Future.delayed(const Duration(seconds: 1), () {
      enColors[en] = AppColors.secondColor;
      arColors[ar] = AppColors.secondColor;
    });
  }

  @override
  void onClose() {
    // animationController.dispose();
    print("\ncontroller closed\n\n");
    super.onClose();
  }

  // void exitQuiz() async {}
  void endQuiz(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.secondColor,
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Are You Sure You Want To End The Quiz?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          // onClose();
                          dbController.selectWords();
                          Get.back();
                          Get.back();
                          // Get.to(StatsPage);
                        },
                        child: const Text("Yes"),
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
