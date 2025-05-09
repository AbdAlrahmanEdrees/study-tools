import 'package:get/get.dart';

class TasksController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String taskName, int expectedPomodoroStages) {
    tasks.add(
        Task(name: taskName, expectedPomodoroStages: expectedPomodoroStages));
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
  }

  void incrementTaskStages(int index) {
    tasks[index].stages++;
    tasks.refresh();
  }
}

class Task {
  String name;
  bool isCompleted;
  int stages;
  int expectedPomodoroStages;

  Task({
    this.name = "No Task",
    this.isCompleted = false,
    this.stages = 0,
    this.expectedPomodoroStages = 0,
  });
}
