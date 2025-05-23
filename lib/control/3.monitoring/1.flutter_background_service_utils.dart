import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/3.monitoring/2.get_usage_stats.dart';
import 'package:studytools/control/3.monitoring/3.receive_intent_controller.dart';

Future<void> initializeBackGroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStartOnBoot: true));

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
//We will be setting up listerns over here to talk to the Native Android side.
  // Make the service background/foreground and start/stop the service.
  DartPluginRegistrant.ensureInitialized(); // Needed to access plugins
  DbController dbController = Get.put(DbController(), permanent: true);
  ReceiveSharingIntentController sharingIntentController =
      Get.put(ReceiveSharingIntentController(), permanent: true);
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      //if you don't' assign constum notification, comment this
      service.setForegroundNotificationInfo(
          title: "My notification", content: "Updated at ${DateTime.now()}");
      debugPrint("Hello");

      String? pkg = await getCurrentForegroundAppPackageName();
      print(pkg);
      print(sharingIntentController.sharedFiles);
      // We don't want the overlay to pop up like crazy
      // If it popped up in the last 30min, we will allow the user to use this app
      //without popping up the overlay window again.
      if (pkg != null && !(await FlutterOverlayWindow.isActive())) {
        if (dbController.monitoredApps
            .any((app) => app["package_name"] == pkg)) {
          await FlutterOverlayWindow.showOverlay(
              overlayTitle: "Overlay",
              overlayContent: "Monitoring App",
              //enableDrag: true,
              flag: OverlayFlag.focusPointer);
        }
      }
    }
  });
}





// //We will be setting up listerns over here to talk to the Native Android side.
//   // Make the service background/foreground and start/stop the service.
//   DartPluginRegistrant.ensureInitialized(); // Needed to access plugins
//   DbController _dbController = Get.put(DbController(), permanent: true);
//   ReceiveSharingIntentController sharingIntentController =
//       Get.put(ReceiveSharingIntentController(), permanent: true);
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   Timer.periodic(const Duration(seconds: 2), (timer) async {
//     if (service is AndroidServiceInstance) {
//       //if you don't' assign constum notification, comment this
//       service.setForegroundNotificationInfo(
//           title: "My notification", content: "Updated at ${DateTime.now()}");
//       debugPrint("Hello");

//       String? pkg = await getCurrentForegroundAppPackageName();
//       print(pkg);
//       print(sharingIntentController.sharedFiles);
//       // We don't want the overlay to pop up like crazy
//       // If it popped up in the last 30min, we will allow the user to use this app
//       //without popping up the overlay window again.
//       if (pkg != null && !(await FlutterOverlayWindow.isActive())) {
//         if (_dbController.monitoredApps
//             .any((app) => app["package_name"] == pkg)) {
//           await FlutterOverlayWindow.showOverlay(
//               overlayTitle: "Overlay",
//               overlayContent: "Monitoring App",
//               //enableDrag: true,
//               flag: OverlayFlag.focusPointer);
//         }
//       }
//     }
//   });

