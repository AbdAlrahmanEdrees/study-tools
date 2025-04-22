import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:tester/controller/0.dbcontroller.dart';
import 'package:tester/controller/5.get_usage_stats.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized(); // Needed to access plugins
  DbController _dbController=Get.put(DbController());
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if (!(await service.isForegroundService())) {
        return;
      }
      print(' [Background] Service running...');
      //This is where we will put our custom background logic!
      //  ->  (check app usage and show overlay :) <-

      print("Hello each 2 secondsssssss \n");
      String? pkg = await getCurrentForegroundAppPackageName();
      print(pkg);
      if(pkg!=null && !(await FlutterOverlayWindow.isActive())) {
        if(_dbController.monitoredApps
        .any((app) => app["package_name"] == pkg)){
          await FlutterOverlayWindow.showOverlay(
            overlayTitle: "Overlay",
            overlayContent: "Monitoring App",
            enableDrag: true,
          );
        }
      }
    }
  });
}
