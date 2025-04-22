import 'package:flutter/material.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:get/get.dart';
import 'package:studytools/model/appcolors.dart';

class AddTaskPage extends StatelessWidget {
  final String name, action;
  final int id, pomodoroStages;
  const AddTaskPage(
      {super.key,
      this.name = "",
      this.pomodoroStages = 1,
      this.id = 1,
      this.action = "Add"});
  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.put(DbController());
    final TextEditingController textEditingController = TextEditingController();
    final RxInt expectedPomodoroStages = pomodoroStages.obs;
    textEditingController.text = name;
    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: AppBar(
        title: const Text('Task Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              style: const TextStyle(color: AppColors.dark),
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
                      'Expected Pomodoro Stages: ${expectedPomodoroStages.value}',
                      style: TextStyle(fontSize: 15,color: AppColors.red3),),
                  Slider(
                    value: expectedPomodoroStages.value.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: expectedPomodoroStages.value.toString(),
                    onChanged: (value) {
                      expectedPomodoroStages.value = value.toInt();
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
                if (action == "Add") {
                  controller.addTask(
                      textEditingController.text, expectedPomodoroStages.value);
                } else {
                  controller.editTask(textEditingController.text,
                      expectedPomodoroStages.value, id);
                }
              },
              child: Text(action),
            ),
            // Expanded(
            //   child: Obx(() {
            //     if (controller.tasks.isEmpty) {
            //       return const Center(child: Text('No tasks added.'));
            //     } else {
            //       return ListView.builder(
            //         itemCount: controller.tasks.length,
            //         itemBuilder: (context, index) {
            //           final task = controller.tasks[index];
            //           return ListTile(
            //             leading: Checkbox(
            //               value: task.isCompleted,
            //               onChanged: (value) {
            //                 controller.toggleTaskCompletion(index);
            //               },
            //             ),
            //             title: Text(
            //               task.name,
            //               style: TextStyle(
            //                 decoration: task.isCompleted
            //                     ? TextDecoration.lineThrough
            //                     : TextDecoration.none,
            //               ),
            //             ),
            //             trailing: Text(
            //               'Stages: ${task.stages} / ${task.expectedPomodoroStages}',
            //             ),
            //             onTap: () {
            //               // Get.offAndToNamed(PomodoroPage.routeName,
            //               //     arguments: task);
            //             },
            //           );
            //         },
            //       );
            //     }
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
