import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';

import 'widgets/audio_section.dart';
import 'widgets/timer_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController controller = Get.put(DbController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Settings',
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color:
                HSVColor.fromColor(Colors.red).withSaturation(0.75).toColor(),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  AudioSection(),
                  const Divider(),
                  Row(
                    children: [
                      Text('Dr. Kamal\'s Quest: '),
                      Obx(() => Checkbox(
                          value: (controller.clockType.value == 'minutes')
                              ? false
                              : true,
                          onChanged: (value) {
                            if (value != null) {
                              if (value == true) {
                                controller.updateClockType('seconds');
                              } else {
                                controller.updateClockType('minutes');
                              }
                            }
                          })),
                    ],
                  ),
                  const Divider(),
                  TimerSection(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
