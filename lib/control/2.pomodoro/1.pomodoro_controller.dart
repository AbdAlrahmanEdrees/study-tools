import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:studytools/control/0.dbcontroller.dart';

import '2.audio_controller.dart';

enum PomodoroStatus {
  started,
  stopped,
}

class PomodoroController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AudioController _audioController = Get.put(AudioController());
  final DbController _dbController = Get.put(DbController());
  late final AnimationController _animationController;
  late final animation;

  int _index = 0;
  final canReset = false.obs;
  final status = PomodoroStatus.stopped.obs;

  final List<Duration> _pomodoroDurationList = [];

  @override
  void onInit() {
    super.onInit();

    _pomodoroDurationList.clear();
    _pomodoroDurationList.addAll(_resetDurationList());

    _animationController = AnimationController(
      vsync: this,
      duration: _pomodoroDurationList[_index],
    )..addStatusListener((animationStatus) async {
        if (animationStatus == AnimationStatus.completed) {
          await _audioController.ring();
          print("complete\n\n\n");
          completed();
        }
      });
    animation = _setAnimation(_animationController).obs;

    _dbController.pomodoroSettings.listen((p0) {
      //like this we ensure that the reset function is called after the thread
      //that is updating the database has finished updating.
      reset();
    });
  }

  void completed() {
    if (_pomodoroDurationList[_index] ==
        Duration(
            minutes: _dbController.pomodoroSettings[0]['pomodoro_duration'])||
            _pomodoroDurationList[_index] ==
        Duration(
            seconds: _dbController.pomodoroSettings[0]['pomodoro_duration'])) {
      if (_dbController.name_of_working_on_task.value != "") {
        _dbController.achievePomodoroStageOfTask();
      } else {
        //if the user is not working on a specific task from his tasks list
        //we just update the statistics table (plus one on statistics.pomodoro_stages)
        _dbController.achievePomodoroStage();
      }
    }
    if (_pomodoroDurationList.length <= _index) {
      _index = 0;
    }
    _index++;
    stop();
    _resetAnimation();
  }

  Animation<double> _setAnimation(AnimationController animationController) {
    if (_dbController.pomodoroSettings[0]['type_of_clock'] == 'minutes') {
      return Tween(
        begin: _pomodoroDurationList[_index].inMinutes.toDouble(),
        end: 0.0,
      ).animate(animationController);
    }else{
    return Tween(
      begin: _pomodoroDurationList[_index].inSeconds.toDouble(),
      end: 0.0,
    ).animate(animationController);}
  }

  List<Duration> _resetDurationList() {
    List<Duration> list = [];
    if (_dbController.pomodoroSettings[0]['type_of_clock'] == 'minutes') {
      for (int i = 0; i < 4; i++) {
        list.add(Duration(
            minutes: _dbController.pomodoroSettings[0]['pomodoro_duration']));
        list.add(Duration(
            minutes: _dbController.pomodoroSettings[0]
                ['short_break_duration']));
      }
      list.add(Duration(
          minutes: _dbController.pomodoroSettings[0]['long_break_duration']));
    } else {
      for (int i = 0; i < 4; i++) {
        list.add(Duration(
            seconds: _dbController.pomodoroSettings[0]['pomodoro_duration']));
        list.add(Duration(
            seconds: _dbController.pomodoroSettings[0]
                ['short_break_duration']));
      }
      list.add(Duration(
          seconds: _dbController.pomodoroSettings[0]['long_break_duration']));
    }

    return list;
  }

  void _resetAnimation() {
    _animationController.duration = _pomodoroDurationList[_index];
    _animationController.reset();
    animation(_setAnimation(_animationController));
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  start() {
    status(PomodoroStatus.started);
    _animationController.forward();
    _audioController.startTicking();
    canReset(true);
  }

  stop() {
    status(PomodoroStatus.stopped);
    _animationController.stop();
    _audioController.stopTicking();
  }

  reset() {
    stop();
    _index = 0;

    _pomodoroDurationList.clear();
    _pomodoroDurationList.addAll(_resetDurationList());

    _resetAnimation();
    canReset(false);
  }
}
