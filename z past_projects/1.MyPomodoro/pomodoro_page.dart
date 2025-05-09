import '../3.pomodoro_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:studytools/view/2.pomodoro/widgets/clock_cap.dart';
import 'package:studytools/view/2.pomodoro/widgets/main_body.dart';

class PomodoroPage extends GetView<PomodoroController> {
  static const routeName = '/pomodoro';
  //final Task task = Get.arguments ?? Task();

  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const MainBody(),
          Obx(
            () => AnimatedBuilder(
                animation: controller.animation.value,
                builder: (animContext, widget) {
                  return ClockCap(
                    barCount: 25,
                    progression: controller.animation.value.value,
                  );
                }),
          ),
          Obx(
            () => Visibility(
              visible: controller.canReset.value,
              child: Positioned(
                bottom: 20,
                left: 20,
                child: TextButton(
                  onPressed: controller.reset,
                  child: const Column(
                    children: [
                      Icon(
                        Icons.undo,
                        color: Colors.white70,
                      ),
                      Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Get.toNamed(SettingsPage.routeName);
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white70,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              width: 300,
              //width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: SizedBox(
                height: 300,
                child: InkWell(
                  onTap: (() {
                    Get.toNamed(TaskPage.routeName);
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Task: ${task.name}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Expected Stages: ${task.expectedPomodoroStages}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Current Stages: ${task.stages}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: task.stages /
                            (task.expectedPomodoroStages > 0
                                ? task.expectedPomodoroStages
                                : 1),
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: controller.status.value == PomodoroStatus.started
                  ? controller.stop
                  : controller.start,
              tooltip: 'Start/Stop Pomodoro',
              child: Icon(controller.status.value == PomodoroStatus.started
                  ? Icons.pause
                  : Icons.play_arrow),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                Get.toNamed(StatisticsPage.routeName);
              },
              tooltip: 'Show Statistics',
              child: const Icon(Icons.bar_chart),
            ),
            const SizedBox(height: 16),
            //  FloatingActionButton(
            //    onPressed:(){

            //   Get.toNamed(TestsPage.routeName);
            //   },
            //    tooltip: 'Show Tests',
            //    child: const Icon(Icons.assessment),
            //  ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
