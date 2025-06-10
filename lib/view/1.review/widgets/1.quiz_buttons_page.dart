import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';
import 'package:studytools/model/appcolors.dart';

class QuizButtonsPage extends GetView<QuizController> {
  const QuizButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.red3,
            AppColors.red3,
            Colors.red.shade600,
            Colors.red.shade500,
            Colors.red.shade500,
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade500,
            Colors.red.shade500,
            Colors.red.shade600,
            AppColors.red3,
            AppColors.red3,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Obx(() {
        if (controller.dbWords.length < 5) {
          return const Center(
            child: Text(
              "No Enough Words to Perform a Quiz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.7,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 40),
                      itemBuilder: (context, index) {
                        return Obx(() => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: controller.enButtonsVisibility[index]
                                  ? ElevatedButton(
                                      key: const ValueKey<int>(1),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            controller.enColors[index],
                                        minimumSize: const Size(180, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 5,
                                      ),
                                      onPressed: () {
                                        controller.chooseEng(index);
                                      },
                                      child: Text(
                                        ' ${controller.enShown[index]} ',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      key: ValueKey<int>(2),
                                      height: 60,
                                      width: 180,
                                    ),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 40),
                      itemBuilder: (context, index) {
                        return Obx(() => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: controller.arButtonsVisibility[index]
                                  ? ElevatedButton(
                                      key: const ValueKey<int>(1),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            controller.arColors[index],
                                        minimumSize: const Size(180, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 5,
                                      ),
                                      onPressed: () {
                                        controller.chooseAr(index);
                                      },
                                      child: Text(
                                        ' ${controller.arShown[index]} ',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      key: ValueKey<int>(2),
                                      height: 60,
                                      width: 180,
                                    ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
