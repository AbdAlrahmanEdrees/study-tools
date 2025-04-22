import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/2.pomodoro/1.pomodoro_controller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/2.pomodoro/widgets/buttons.dart';
import 'package:studytools/view/2.pomodoro/widgets/clock_cap.dart';
import 'package:studytools/view/2.pomodoro/widgets/main_body.dart';
import 'package:studytools/view/2.pomodoro/widgets/task_card.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    PomodoroController pomodoroController = Get.put(PomodoroController());
    DbController dbController = Get.put(DbController());
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors.yellow),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          MainBody(),
          Obx(
            () => AnimatedBuilder(
                animation: pomodoroController.animation.value,
                builder: (animContext, widget) {
                  return GetBuilder<DbController>(
                    builder: (controller) => ClockCap(
                      //barCount should be the highest value (int minutes) the user
                      //selected in the settings_page/timer_section
                      barCount: dbController.barCount.value,
                      progression: pomodoroController.animation.value.value,
                    ),
                  );
                }),
          ),
          GetBuilder<DbController>(builder: (controller)=>TasksCard()),
          Buttons(),
        ],
      ),
    );
  }
}
