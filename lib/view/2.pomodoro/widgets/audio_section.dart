// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/2.pomodoro/2.audio_controller.dart';

class AudioSection extends StatelessWidget {
  const AudioSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.put(DbController());
    final AudioController audioController = Get.put(AudioController());
    return Column(children: [
      Row(
        children: [
          const Expanded(
            child: Text(
              'Ticking Volume',
              //style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Obx(() => Slider(
              value: controller.pomodoroSettings[0]['ticking_volume'],
              onChanged: (volume) {
                controller.updateTickingVolume(volume);
                audioController.tickPlayer.setVolume(volume);
              })),
        ],
      ),
      Row(
        children: [
          const Expanded(
            child: Text(
              'Ringing Volume',
              //style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Obx(() => Slider(
              value: controller.pomodoroSettings[0]['ringing_volume'],
              onChanged: (volume) {
                controller.updateRingingVolume(volume);
                audioController.ringPlayer.setVolume(volume);
              })),
        ],
      ),
    ]);
  }
}
