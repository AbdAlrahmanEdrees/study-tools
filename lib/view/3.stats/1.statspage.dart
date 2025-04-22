import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';

class StatsPage extends StatelessWidget {
  StatsPage({super.key});
  final List<String> statistics_names = [
    'Number of Tasks Not Achieved',
    'Number of Stories',
    'Number of Words',
    'Highest Correct Answers Streak',
    'Number of Quizzes Taken',
    'Number of Achieved Tasks',
    'Number of Stories Added'
        'Number of Words Added',
    'Number of Achieved Pomodoro Stages'
  ];
  @override
  Widget build(BuildContext context) {
    DbController controller = Get.put(DbController());

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 204, 17, 17),
          // color: Colors.black,
          gradient: LinearGradient(
            colors: [
              Colors.red.shade900,
              Colors.red.shade700,
              Colors.red.shade700,
              Colors.red.shade500,
              Colors.red.shade400,
              Colors.red.shade400,
              Colors.red.shade500,
              Colors.red.shade700,
              Colors.red.shade700,
              Colors.red.shade900,
              // Color(0xFFCB2611),
              // Colors.red,
              // Color(0xFFCB2611),
              // HSVColor.fromColor(Colors.red).toColor(),
              // HSVColor.fromColor(Colors.red).toColor(),
              // HSVColor.fromColor(Colors.red).toColor(),
              // HSVColor.fromColor(AppColors.red2).toColor(),
              // HSVColor.fromColor(AppColors.yellow).toColor(),
              // HSVColor.fromColor(AppColors.red2).toColor(),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.height / 30,
            ),
            SizedBox(
                height: context.height / 3.5,
                width: context.width / 1.05,
                child: Card(
                  color: Colors.white60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Current",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Number of Tasks Not Achieved',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]
                                    ['no_of_curr_not_achieved_tasks']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            "Number of Stories",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_curr_stories']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Number of Words',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_curr_words']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: context.height / 70,
            ),
            SizedBox(
              height: context.height / 10,
              width: context.width / 1.05,
              child: Card(color: Colors.white60, child:Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Highest Correct-Answers Streak',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['highest_correct_answers_streak']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),),
            ),
            SizedBox(
              height: context.height / 70,
            ),SizedBox(
                height: context.height / 2.9,
                width: context.width / 1.05,
                child: Card(
                  color: Colors.white60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Number of Quizzes Taken',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]
                                    ['no_of_quizzes_taken']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            "Number of Achieved Tasks",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_achieved_tasks']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Number of Stories Added',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_stories_added']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Number of Words Added',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_words_added']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: context.height / 70,
            ),
            SizedBox(
              height: context.height / 8,
              width: context.width / 1.05,
              child: Card(color: Colors.white60, child:Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: context.width / 20,
                          ),
                          Text(
                            'Total Achieved Pomodoro Stages',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(
                            width: context.width / 15,
                          ),
                          Text(
                            controller.statistics[0]['no_of_achieved_pomodoro_stages']
                                .toString(),
                            style:
                                TextStyle(color: AppColors.red4, fontSize: 25),
                          ),
                        ],
                      ),),
            ),
          ],
        ),
      ),
    );
  }
}
