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
  // is ForegroundMode: true, this make the service a foreground service
  //Why it needs to be a foreground service? Because a foreground service remain presistent
  // A background type of service will be closed after the user closes the app, by the system, due to resource management.
  //By having a notification, the system assumes that the user is aware of this service and wants to keep it running.

  // isForegroundMode: false : The background mode requires running in release mode and requires disabling battery optimization
  //so that the service stays up when the user closes the application.

  // ! A foreground service requires a presistent notification
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStartOnBoot: true,
      ));

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

    // most probably we will never make it a background service.
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('refresh_selected_apps').listen(
    (event)async {
      print('refreshing apps...');
      await dbController.selectMonitoredApps();
    },
  );
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 2), (timer) async {
    // print(sharingIntentController.sharedFiles);
    // print(sharingIntentController.sharedText);
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
              alignment: OverlayAlignment.topCenter,
              overlayTitle: "Overlay",
              overlayContent: "Monitoring App",
              //enableDrag: true,
              flag: OverlayFlag.focusPointer);

          //Overlay Window runs in an isolate (doesn't share memory with other threads),
          // so we talk to it throw messages like this:
          await FlutterOverlayWindow.shareData('reset_animation');
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

