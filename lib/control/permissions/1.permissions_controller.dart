import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studytools/view/1.homepage.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionsScreenController extends GetxController {
  RxBool hasOverlayPermission = false.obs;
  RxBool hasUsagePermission = false.obs;
  RxBool hasStoragePermission = false.obs;
  RxBool hasManageExternalStoragePermission = false.obs;
  late Timer timer;
  @override
  void onInit() {
    super.onInit();

    // Start periodic check every 3 seconds
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (hasOverlayPermission.value &&
          hasUsagePermission.value &&
          hasStoragePermission.value &&
          hasManageExternalStoragePermission.value) {
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
    final storage = await Permission.storage.status.isGranted;
    final externalStorage =
        await Permission.manageExternalStorage.status.isGranted;
    hasOverlayPermission.value = overlay;
    hasUsagePermission.value = usage!;
    hasStoragePermission.value = storage;
    hasManageExternalStoragePermission.value = externalStorage;
    if (overlay && usage && storage && externalStorage) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.offAll(() => const HomePage());
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

  Future<void> requestStoragePermission() async {
    await Permission.storage.request();
    checkPermissions();
  }

  Future<void> requestManageExternalStoragePermission() async {
    print("trying....");
    await Permission.manageExternalStorage.request();
    checkPermissions();
  }
}
