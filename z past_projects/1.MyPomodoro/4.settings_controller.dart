import 'package:get/get.dart';
import 'package:studytools/model/constants.dart';

class SettingsController extends GetxController {

  // Timer Related Properties
  final shortBreakDuration = kShortBreakDurationList[kInitialIndex].obs;
  final longBreakDuration = kLongBreakDurationList[kInitialIndex].obs;
  final pomodoroDuration = kPomodoroDurationList[kInitialIndex].obs;

  @override
  void onInit() {
    super.onInit();

    final storedShortBreakDurationValue = box.read('shortBreakDuration') ?? shortBreakDuration.value;
    final storedLongBreakDurationValue = box.read('longBreakDuration') ?? longBreakDuration.value;
    final storedPomodoroDurationValue = box.read('pomodoroDuration') ?? pomodoroDuration.value;
    shortBreakDuration(storedShortBreakDurationValue);
    longBreakDuration(storedLongBreakDurationValue);
    pomodoroDuration(storedPomodoroDurationValue);

  }

  void updateRingingVolume(double volume) {
    ringingVolume(volume);
    box.write('ringingVolume', volume);
  }

  void updateTickingVolume(double volume) {
    tickingVolume(volume);
    box.write('tickingVolume', volume);
  }

  void updateShortBreakDuration(int? minutes) {
    shortBreakDuration(minutes);
    box.write('shortBreakDuration', minutes);
  }

  void updateLongBreakDuration(int? minutes) {
    longBreakDuration(minutes);
    box.write('longBreakDuration', minutes);
  }

  void updatePomodoroDuration(int? minutes) {
    pomodoroDuration(minutes);
    box.write('pomodoroDuration', minutes);
  }
}
