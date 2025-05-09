import 'package:flutter/material.dart';
import 'package:refreshing/controllers/tasks_controller.dart';
import 'package:refreshing/pages/pomodoro/pomodoro_page.dart';
import 'package:get/get.dart';

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  TaskPage({super.key});
  final TextEditingController _textEditingController = TextEditingController();
  final TasksController _taskController = Get.find();
  final RxInt _expectedPomodoroStages = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: "Enter your task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Expected Pomodoro Stages: ${_expectedPomodoroStages.value}'),
                  Slider(
                    value: _expectedPomodoroStages.value.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _expectedPomodoroStages.value.toString(),
                    onChanged: (value) {
                      _expectedPomodoroStages.value = value.toInt();
                    },
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  _taskController.addTask(_textEditingController.text,
                      _expectedPomodoroStages.value);
                  _textEditingController.clear();
                }
              },
              child: const Text('Add Task'),
            ),
            Expanded(
              child: Obx(() {
                if (_taskController.tasks.isEmpty) {
                  return const Center(child: Text('No tasks added.'));
                } else {
                  return ListView.builder(
                    itemCount: _taskController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = _taskController.tasks[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            _taskController.toggleTaskCompletion(index);
                          },
                        ),
                        title: Text(
                          task.name,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Text(
                          'Stages: ${task.stages} / ${task.expectedPomodoroStages}',
                        ),
                        onTap: () {
                          Get.offAndToNamed(PomodoroPage.routeName,
                              arguments: task);
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
