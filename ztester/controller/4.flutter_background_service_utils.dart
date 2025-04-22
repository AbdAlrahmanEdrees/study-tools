import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:tester/controller/3.monitoring_service.dart';

Future<void> initislizeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
          autoStart: true,
          initialNotificationTitle: 'App Monitor Running',
          initialNotificationContent: "the app is monitoring - ^"),
      iosConfiguration: IosConfiguration());

  await service.startService();
}
