import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';
import 'package:studytools/model/appcolors.dart';

class QuizPage extends StatelessWidget {
  final bool backButtonVisibility;
  //When we put the quiz page in the overlay window, we don't want the appBar's back button to be visible
  const QuizPage({super.key, this.backButtonVisibility = true});
  // final QuizController controller = Get.find<QuizController>();
  // final QuizController controller = Get.put(QuizController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    //The only right way is this (to ->put<- the controller, and put it here inside the builder) for these reasons:
    //1- when we get back and get in the page again, we want a new quiz to be generated, and for that we need to refresh
    // almost all the variables of QuizController, so deleting in when we get back and creating another one on build is easier
    //2- in the main we call the DbController, and it takes time until the words are loaded, so we initiate the QuizController here, 
    // until the user open this page, the words will be loaded, and there will be no error initiating the QuizController.
    final QuizController controller = Get.put(QuizController());
    // in the quiz buttons page, sometimes this error occurs (no quiz controller, Get.put or Get.lazyput -_-...) / and sometimes it doesn't happen
    // This is because the controller takes sometime before it is really putted in memory after Get.put
    return SizedBox(
      // We will later put this page inside the overlay window, and exactly inside the Column widget of the overlay window
      // And widgets like Column has unbounded hight, so when you put a scaffold (a widget that requires a finite size) with unbounded hight inside a column which has
      // unbounded hight there's gonna be an error
      // also you can't put widgets that requires a finite size like ListView, Scaffold or Stack inside a widget of unbounded hight.
      height: context.height * 0.7,
      child: Scaffold(
        backgroundColor: AppColors.red1,
        appBar: AppBar(
          toolbarHeight: 100, // تقليل الارتفاع
          backgroundColor: AppColors.red1,
          leading: Visibility(
            visible: backButtonVisibility,
            child: IconButton(
              onPressed: () {
                controller.endQuiz(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          title: Obx(() => Padding(
                padding:
                    const EdgeInsets.only(top: 8.0), // رفع المحتوى داخل AppBar
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
