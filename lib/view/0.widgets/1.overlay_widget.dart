import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

import 'package:studytools/control/3.monitoring/4.overlay_window_controller.dart';
import 'package:studytools/view/0.widgets/2.home_page_drawer.dart';
import 'package:studytools/view/1.review/6.quiz_page.dart';

class OverlayWindow extends StatelessWidget {
  OverlayWindow({super.key});
  final OverlayWindowController controller =
      Get.put(OverlayWindowController(), permanent: true);

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
                height: 10,
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
                              await FlutterOverlayWindow.closeOverlay();
                              controller.animationIsRunning.value = true;
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ))),
            ElevatedButton(
              onPressed: () async {
                await FlutterOverlayWindow.closeOverlay();
                controller.animationIsRunning.value = true;
              },
              child: const Text("Close Overlay"),
            ),
            // QuizPage(),
          ],
        ),
      ),
    );
  }
}
