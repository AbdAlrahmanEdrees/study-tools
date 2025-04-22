import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/controller/4.flutter_background_service_utils.dart';
import 'package:tester/model/sqldb.dart';
import 'package:tester/view/flutter_overlay_widget.dart';
import 'package:tester/view/home.dart';
import 'package:tester/view/permissions_page.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Ensures everything is ready before running the app

  //initializing the SQFlite Db
  SqlDb sqlDb = SqlDb();
  await sqlDb.db;

  // Start background monitoring
  await initislizeService();

  // check if the permissions are granted
  // note: if you removed the '!' after the checkUsagePermission there will be a 'nullable-error'
  //by adding ! you are telling dart "I am sure that this value will not be null"
  bool permissionsAailable = (await UsageStats.checkUsagePermission())! &&
      (await FlutterOverlayWindow.isPermissionGranted());

  runApp(MyApp(
    permissionsGranted: permissionsAailable,
  ));
}

// This is the 'isolate' entry for the Alert Window Service
// It needs to be added in teh main.dart file with the name "overlayMain"...
@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const OverlayWidget());
}

class MyApp extends StatelessWidget {
  final bool permissionsGranted;
  const MyApp({super.key, required this.permissionsGranted});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: permissionsGranted ? Home() : PermissionsPage());
  }
}
