import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/2.pomodoro/1.pomodoro_controller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/2.pomodoro/2.settingspage.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    PomodoroController controller = Get.put(PomodoroController());
    return Positioned(
        bottom: 10,
        child: Stack(
          children: [
            // SizedBox(width: context.width / 5),
            SizedBox(
              width: context.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: context.width / 1.7,
                      height: context.height / 15,
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.status.value == PomodoroStatus.started
                                    ? AppColors.red3
                                    : const Color.fromARGB(255, 64, 174, 84),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed:
                              controller.status.value == PomodoroStatus.started
                                  ? controller.reset
                                  : controller.start,
                          child: Icon(
                              controller.status.value == PomodoroStatus.started
                                  ? Icons.undo
                                  : Icons.play_arrow),
                        ),
                      )),
                ],
              ),
            ),
            // SizedBox(
            //   width: context.width / 10,
            // ),
            SizedBox(
              width: context.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: context.width / 10,
                      ),
                  IconButton(
                      onPressed: () {
                        Get.to(SettingsPage());
                      },
                      icon: const Icon(Icons.settings)),
                ],
              ),
            )
          ],
        ));
  }
}
