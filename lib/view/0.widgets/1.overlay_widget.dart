import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final showTrigger = false.obs;

  void triggerOverlay() {
    showTrigger.value = !showTrigger.value;
    animationController.reset();
    animationController.forward();
  }

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          animationController.forward();
          Get.back();
          await FlutterOverlayWindow.closeOverlay();
        }
      });

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.reset();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class OverlayWidget extends StatelessWidget {
  OverlayWidget({super.key});
  final OverlayController controller = Get.put(OverlayController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: UniqueKey(),
      title: 'Overlay',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, size: 80, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                "You're using a monitored app!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(() {
                  controller.update();
                  controller.triggerOverlay();
                  return AnimatedBuilder(
                    animation: controller.animation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: controller.animation.value,
                        backgroundColor: Colors.white30,
                        color: Colors.white,
                        minHeight: 8,
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              // ElevatedButton(
              //   onPressed: () async {
              //     await FlutterOverlayWindow.closeOverlay();
              //   },
              //   child: const Text("Close Overlay"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
