import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:tester/view/home.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionsScreenController extends GetxController {
  RxBool hasOverlayPermission = false.obs;
  RxBool hasUsagePermission = false.obs;
  late Timer timer;
  @override
  void onInit() {
    super.onInit();

    // Start periodic check every 3 seconds
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (hasOverlayPermission.value && hasUsagePermission.value) {
        timer.cancel();
        //print("timer cancelled on the condition");
      } else {
        checkPermissions();
      }
    });
  }


  Future<void> checkPermissions() async {
    final overlay = await FlutterOverlayWindow.isPermissionGranted();
    final usage = await UsageStats.checkUsagePermission();
    hasOverlayPermission.value = overlay;
    hasUsagePermission.value = usage!;

    if (overlay && usage) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAll(() => const Home());
      });
    }
  }

  Future<void> requestUsagePermission() async {
    await UsageStats.grantUsagePermission();
    checkPermissions();
  }

  Future<void> requestOverlayPermission() async {
    await FlutterOverlayWindow.requestPermission();
    checkPermissions();
  }
}
