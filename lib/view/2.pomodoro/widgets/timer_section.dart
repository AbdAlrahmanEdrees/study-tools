import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/constants.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdownSection(
          icon: Icons.timer,
          label: 'Pomodoro Duration',
          items: kPomodoroDurationList,
          getValue: () => controller.pomodoroSettings[0]['pomodoro_duration'],
          onChanged: (val) => controller.updatePomodoroDuration(val as int),
          unitGetter: () => controller.pomodoroSettings[0]['type_of_clock'],
        ),
        _buildDropdownSection(
          icon: Icons.coffee,
          label: 'Short Break Duration',
          items: kShortBreakDurationList,
          getValue: () =>
              controller.pomodoroSettings[0]['short_break_duration'],
          onChanged: (val) => controller.updateShortBreakDuration(val as int),
          unitGetter: () => controller.pomodoroSettings[0]['type_of_clock'],
        ),
        _buildDropdownSection(
          icon: Icons.hotel,
          label: 'Long Break Duration',
          items: kLongBreakDurationList,
          getValue: () => controller.pomodoroSettings[0]['long_break_duration'],
          onChanged: (val) => controller.updateLongBreakDuration(val as int),
          unitGetter: () => controller.pomodoroSettings[0]['type_of_clock'],
        ),
      ],
    );
  }

  Widget _buildDropdownSection({
    required IconData icon,
    required String label,
    required List<int> items,
    required int Function() getValue,
    required ValueChanged<Object?> onChanged,
    required String Function() unitGetter,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Obx(() {
            final value = getValue();
            final unit = unitGetter();
            return DropdownButton<int>(
              isExpanded: true,
              dropdownColor: Colors.black87,
              iconEnabledColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              value: value,
              items: items
                  .map((e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e $unit'),
                      ))
                  .toList(),
              onChanged: onChanged,
              underline: Container(
                height: 1,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }
}
