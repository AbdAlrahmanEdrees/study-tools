// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:refreshing/constants.dart';

class TimerSection extends StatelessWidget {
  final int shortBreakDuration;
  final int longBreakDuration;
  final int pomodoroDuration;

  final Function(int?) pomodoroDurationCallback;
  final Function(int?) longBreakDurationCallback;
  final Function(int?) shortBreakDurationCallback;

  const TimerSection({
    super.key,
    required this.pomodoroDuration,
    required this.longBreakDuration,
    required this.shortBreakDuration,
    required this.pomodoroDurationCallback,
    required this.longBreakDurationCallback,
    required this.shortBreakDurationCallback,
  });

  @override
  Widget build(BuildContext context) {
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
              DropdownButton(
                isExpanded: true,
                items: kPomodoroDurationList
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e minutes'),
                      ),
                    )
                    .toList(),
                onChanged: pomodoroDurationCallback,
                value: pomodoroDuration,
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
              ),
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
              DropdownButton(
                isExpanded: true,
                items: kShortBreakDurationList
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e minutes'),
                      ),
                    )
                    .toList(),
                onChanged: shortBreakDurationCallback,
                value: shortBreakDuration,
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
              ),
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
              DropdownButton(
                isExpanded: true,
                items: kLongBreakDurationList
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e minutes'),
                      ),
                    )
                    .toList(),
                onChanged: longBreakDurationCallback,
                value: longBreakDuration,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
