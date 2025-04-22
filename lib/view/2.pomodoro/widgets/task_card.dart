import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/2.pomodoro/3.tasks_list_page.dart';

class TasksCard extends StatelessWidget {
  const TasksCard({super.key});

  @override
  Widget build(BuildContext context) {
    DbController controller = Get.put(DbController());
    return Positioned(
        top: context.height / 5,
        child: SizedBox(
            height: context.height / 2,
            width: context.width / 1.5,
            child: ElevatedButton(
              onPressed: () {
                Get.to(TasksListPage());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  shape: const RoundedRectangleBorder()),
              child:  Stack(children: [
                  Center(
                    child: Obx(()=>Text(
                      controller.name_of_working_on_task.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(()=>Text(controller.done_to_need_to_be_done.value,
                      textAlign: TextAlign.center,))
                    ],
                  )
                ]),
              ),
            ));
  }
}
// Container(
//         color: AppColors.yellow,
//         height: context.height/ 2,
//         width: context.width/2,)
