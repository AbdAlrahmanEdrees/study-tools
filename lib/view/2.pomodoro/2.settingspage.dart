import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'widgets/audio_section.dart';
import 'widgets/timer_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Settings'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color:
                  HSVColor.fromColor(Colors.red).withSaturation(0.75).toColor(),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Audio Section
                    AudioSection(),

                    const Divider(color: Colors.white70),

                    // Clock Type (Dr. Kamal's Quest)
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'Convert minutes to seconds: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Obx(() => Checkbox(
                            activeColor: Colors.green,
                            value: (controller.clockType.value == 'minutes')
                                ? false
                                : true,
                            onChanged: (value) {
                              if (value != null) {
                                controller.updateClockType(
                                    value ? 'seconds' : 'minutes');
                              }
                            })),
                      ],
                    ),

                    const Divider(color: Colors.white70),

                    // Timer Section
                    TimerSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
