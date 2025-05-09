// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

// Future<void> initislizeService() async {
//   final service = FlutterBackgroundService();

//   await service.configure(
//       androidConfiguration: AndroidConfiguration(

//           //this will be executed when app is in foreground or background
//           // in separate isolate
//           onStart: onStart,
//           isForegroundMode: true,
//           // autoStart: true,
//           autoStartOnBoot: true,
//           // initialNotificationTitle: 'App Monitor Running',
//           // initialNotificationContent: "the app is monitoring - ^"
//           ),
//       iosConfiguration: IosConfiguration());

//   await service.startService();
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   //We will be setting up listerns over here to talk to the Native Android side.
//   // to make the service background/foreground and start/stop the service.
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

//   Timer.periodic(const Duration(seconds: 2), (timer) {
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//           title: "My notification", content: "Updated at ${DateTime.now()}");
//     }
//     debugPrint("HI");
//   });

//   // // We will be setting up listerns over here to talk to the Native Android side.
//   // // Make the service background/foreground and start/stop the service.
//   // DartPluginRegistrant.ensureInitialized(); // Needed to access plugins
//   // DbController _dbController = Get.find<DbController>();
//   // service.on('stopService').listen((event) {
//   //   service.stopSelf();
//   // });
//   // Timer.periodic(const Duration(seconds: 2), (timer) async {
//   //   if (service is AndroidServiceInstance) {
//   //     if (!(await service.isForegroundService())) {
//   //       return;
//   //     }
//   //     print(' [Background] Service running...');
//   //     //This is where we will put our custom background logic!
//   //     //  ->  (check app usage and show overlay :) <-

//   //     print("Hello each 2 secondsssssss \n");
//   //     String? pkg = await getCurrentForegroundAppPackageName();
//   //     print(pkg);
//   //     // We don't want the overlay to pop up like crazy
//   //     // If it popped up in the last 30min, we will allow the user to use this app
//   //     //without popping up the overlay window again.
//   //     if (pkg != null && !(await FlutterOverlayWindow.isActive())) {
//   //       if (_dbController.monitoredApps
//   //           .any((app) => app["package_name"] == pkg)) {
//   //         await FlutterOverlayWindow.showOverlay(
//   //             overlayTitle: "Overlay",
//   //             overlayContent: "Monitoring App",
//   //             //enableDrag: true,
//   //             flag: OverlayFlag.focusPointer);
//   //       }
//   //     }
//   //   }
//   // });
// }
