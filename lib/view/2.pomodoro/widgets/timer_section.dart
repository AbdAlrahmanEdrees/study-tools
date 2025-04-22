// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/constants.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.put(DbController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pomodoro Duration',
                //style: Theme.of(context).textTheme.headline6,
              ),
              Obx(() =>  DropdownButton(
                    isExpanded: true,
                    items: kPomodoroDurationList
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e ${controller.pomodoroSettings[0]['type_of_clock']}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value !=
                          controller.pomodoroSettings[0]
                              ['pomodoro_duration']) {
                        controller.updatePomodoroDuration(value as int);
                      }
                    },
                    value: 
                        controller.pomodoroSettings[0]['pomodoro_duration'] as int,
                    iconEnabledColor: Colors.white,
                    underline: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Short Break Duration',
                //style: Theme.of(context).textTheme.headline6,
              ),
              Obx(() => DropdownButton(
                    isExpanded: true,
                    items: kShortBreakDurationList
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e ${controller.pomodoroSettings[0]['type_of_clock']}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value !=
                          controller.pomodoroSettings[0]
                              ['short_break_duration']) {
                        controller.updateShortBreakDuration(value as int);
                      }
                    },
                    value: 
                        controller.pomodoroSettings[0]['short_break_duration'] as int,
                    iconEnabledColor: Colors.white,
                    underline: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Long Break Duration',
                // style: Theme.of(context).textTheme.headline6,
              ),
              Obx(() => DropdownButton(
                    isExpanded: true,
                    items: kLongBreakDurationList
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e ${controller.pomodoroSettings[0]['type_of_clock']}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value !=
                          controller.pomodoroSettings[0]
                              ['long_break_duration']) {
                        controller.updateLongBreakDuration(value as int);
                      }
                    },
                    value: 
                        controller.pomodoroSettings[0]['long_break_duration'] as int,
                    iconEnabledColor: Colors.white,
                    underline: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
