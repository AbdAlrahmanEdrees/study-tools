import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/quizcontroller.dart';

class QuizButtonsPage extends GetView<QuizController> {
  const QuizButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.dbWords.length < 5) {
        return const Center(child: Text("No Enough Words to Perform a Quiz"));
      } else {
        return Row(
          children: [
            Expanded(
              child: ListView.builder(
                // padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 40, 8, 40),
                    child: SizedBox(
                      height: 40,
                      child: Obx(
                        () => AnimatedSwitcher(
                            //makes the animation when the choice is correct
                            duration: const Duration(seconds: 1),
                            child: controller.enButtonsVisibility[index]
                                ? MaterialButton(
                                    minWidth: 180,
                                    key: const ValueKey<int>(
                                        1), //needed for the animation (uniquely identify the widget for the animator)
                                    color: controller.enColors[index],
                                    onPressed: () {
                                      controller.chooseEng(index);
                                    },
                                    child:
                                        Text(' ${controller.enShown[index]} '))
                                : const SizedBox(
                                    key: ValueKey<int>(2),
                                    height: 40,
                                    width: 180,
                                  )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                // padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
                itemCount: 5,
                itemBuilder: (context, index) {
                  // Replace with your item builder logic for the second ListView
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 40, 8, 40),
                    child: SizedBox(
                      height: 40,
                      // width: 100,
                      child: Obx(
                        () => AnimatedSwitcher(
                            duration: const Duration(seconds: 1),
                            child: controller.arButtonsVisibility[index]
                                ? MaterialButton(
                                    minWidth: 180,
                                    key: const ValueKey<int>(1),
                                    color: controller.arColors[index],
                                    onPressed: () {
                                      controller.chooseAr(index);
                                    },
                                    child:
                                        Text(' ${controller.arShown[index]} '))
                                : const SizedBox(
                                    key: ValueKey<int>(2),
                                    height: 40,
                                    width: 180)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
