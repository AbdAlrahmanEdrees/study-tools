import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class OverlayWindowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final animationIsRunning = true.obs;

  void triggerOverlay() {
    animationIsRunning.value = !animationIsRunning.value;
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
          animationIsRunning.value = false;
          update();
        } 
      });

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    FlutterOverlayWindow.overlayListener.listen(
      (event) {
        if (event is String) {
          if (event == 'reset_animation') {
            animationController.reset();
            animationController.forward();
          }
        }
      },
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
