import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';
import 'package:studytools/model/appcolors.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      backgroundColor: Colors.red.shade300,
      appBar: AppBar(
        toolbarHeight: 100, // تقليل الارتفاع
        backgroundColor: AppColors.red1,
        leading: IconButton(
          onPressed: () {
            controller.endQuiz(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Obx(() => Padding(
              padding: const EdgeInsets.only(top: 8.0), // رفع المحتوى داخل AppBar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox('${controller.correct}', '✔', Colors.green),
                  _buildStatBox('${controller.wrong}', '✖', AppColors.red4),
                  _buildStatBox('${controller.streak}', '🔥', Colors.orange),
                ],
              ),
            )),
      ),
      body: GetBuilder<QuizController>(
        builder: (c) => controller.quizPage,
      ),
    );
  }

  Widget _buildStatBox(String value, String icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          icon,
          style: TextStyle(fontSize: 20, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
