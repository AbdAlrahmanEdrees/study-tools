import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/2.pomodoro/4.addtaskpage.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.put(DbController());
    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: AppBar(
        title: const Text(
          "Tasks List",
          style: TextStyle(
              fontSize: 25,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.red1,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddTaskPage());
        },
        backgroundColor: AppColors.red1,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          if (controller.tasks.isEmpty) {
            return const Center(
                child: Text(
              "No Tasks in the DB",
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                final task = controller.tasks[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    children: [
                      SizedBox(
                          // height: 60,
                        child: MaterialButton(
                          // onLongPress: () {},
                          color: AppColors.yellow,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: ListTile(
                                    leading: const Icon(Icons.task,
                                      color: Colors.grey,),
                                    trailing: Text(
                                      "${task['done_pomodoro_stages']}/${task['pomodoro_stages']}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    title: Text(task['task_name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          decoration: (task['task_state'] == 1)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ))),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  // height:40,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        color: Colors.grey,
                                          onPressed: () {
                                            Get.to(AddTaskPage(
                                                name: task['task_name'],
                                                pomodoroStages: task['pomodoro_stages'],
                                                id: task['id'],
                                                action: "Edit"));
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                        color: Colors.grey,
                                        onPressed: () {
                                          controller.deleteTask(task['id']);
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            controller.setWorkingOnTask(task['id']);
                            Get.back();
                          },
                        ),
                      ),
                      Divider(color: AppColors.white)
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
