import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

import 'package:studytools/control/3.monitoring/4.overlay_window_controller.dart';
import 'package:studytools/view/1.review/6.quiz_page.dart';
import 'package:studytools/view/1.review/7.receive_intent_page.dart';

class OverlayWindow extends GetView<OverlayWindowController> {
  OverlayWindow({super.key});
  // final OverlayWindowController controller =
  //     Get.put(OverlayWindowController(), permanent: true);

  // we will do a dynamic pages changer, like we did in 'homepage.dart'
  final List<Widget> pages = [
    nothing(),
    QuizPage(
      backButtonVisibility: false,
    ),
    ReceiveSharingIntentPage(),
    //Translating_Widget_Page(),
    //Reviewer(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => SizedBox(
                height: 15,
                child: controller.animationIsRunning.value
                    ? AnimatedBuilder(
                        animation: controller.animation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: controller.animation.value,
                            backgroundColor: Colors.white30,
                            color: Colors.white,
                            minHeight: 8,
                          );
                        },
                      )
                    : Row(
                        children: [
                          Expanded(child: SizedBox()),
                          IconButton(
                            onPressed: () async {
                              print("closing overlay window");
                              controller.closingOverlay();
                            },
                            icon: const Icon(Icons.close),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Get.find<QuizController>().onClose();
                print('resetting');
                await FlutterOverlayWindow.shareData('reset_animation');
              },
              child: const Text("Refresh quiz"),
            ),
            ElevatedButton(
              onPressed: () async {
                controller.randomIndex();
                print(Get.find<OverlayWindowController>().index.value);
              },
              child: const Text("Change window"),
            ),
            Obx(() => pages[controller.index.value]),
          ],
        ),
      ),
    );
  }
}

Widget nothing() {
  print(Get.find<OverlayWindowController>().index.value);
  return Obx(
      () => Text("Hello  ${Get.find<OverlayWindowController>().index.value}"));
}
