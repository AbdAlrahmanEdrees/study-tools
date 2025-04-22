import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:studytools/control/monitoring/1.monitoring_service.dart';

Future<void> initislizeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      androidConfiguration: AndroidConfiguration(

        //this will be executed when app is in foreground or background
        // in separate isolate
          onStart: onStart,
          isForegroundMode: true,
          autoStart: true,
          initialNotificationTitle: 'App Monitor Running',
          initialNotificationContent: "the app is monitoring - ^"),
      iosConfiguration: IosConfiguration());

  await service.startService();
}
