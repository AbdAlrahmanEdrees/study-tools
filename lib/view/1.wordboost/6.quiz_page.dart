import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';
import 'package:studytools/model/appcolors.dart';
//import 'package:wordup/control/dbcontroller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    //the quiz
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      backgroundColor: Colors.red.shade300,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.red1,
        leading: IconButton(
            onPressed: () {
              // Get.delete<QuizController>(); // if the user got out of the page
              //a new quiz is generated next time
              controller.endQuiz(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Obx(() => Row(
              children: [
                const SizedBox(width:30),
                Expanded(child: Text('${controller.correct}',style: const TextStyle(color:Colors.green))),
                Expanded(child: Text('${controller.wrong}',style: const TextStyle(color:AppColors.red4))),
                Expanded(child: Text('${controller.streak}',style: const TextStyle(color:Colors.orange))),
              ],
            )),
      ),
      body: GetBuilder<QuizController>(builder: (c)=>controller.quizPage)
    );
  }
}
