import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';
import 'package:studytools/control/3.monitoring/1.flutter_background_service_utils.dart';
import 'package:studytools/control/3.monitoring/4.overlay_window_controller.dart';
import 'package:studytools/view/1.homepage.dart';
import 'package:studytools/view/2.permissionspage.dart';
import 'package:studytools/view/0.widgets/1.overlay_widget.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:studytools/view/1.wordboost/widgets/overlay_translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //without the previous line in the beginning, the app will not run, only a black screen
  //will show up, but after I just added this line, the app ran, first a window appeared
  //asking for 'overlay over apps' permission' :) and everything was perfectly fine.
  // The Right Way to Make One Instance Of A Controller:
  final DbController db = Get.put(DbController(),
      permanent: true); //permenant:true <=> stays in memory
  Get.put(TranslationController(db), permanent: true);
  //initializing the SQFlite Db
  // SqlDb sqlDb = SqlDb();
  // await sqlDb.db;

  // Start background monitoring
  await initializeBackGroundService();

  // check if the permissions are granted
  // note: if you removed the '!' after the checkUsagePermission there will be a 'nullable-error'
  //by adding ! you are telling dart "I am sure that this value will not be null"

  // NOTE NOTE NOTE: manageExternalStorage is only on Android 11+
  bool permissionsAailable = (await UsageStats.checkUsagePermission())! &&
      (await FlutterOverlayWindow.isPermissionGranted()) &&
      (await Permission.storage.status.isGranted) &&
      (await Permission.manageExternalStorage.status.isGranted);

  // Get the media sharing coming from outside the app while the app is closed.
  // Get the media sharing coming from outside the app while the app is closed.

  //final sharedMedia = await ReceiveSharingIntent.instance.getInitialMedia();

  // if (sharedMedia.isNotEmpty && sharedMedia[0].type == SharedMediaType.text) {
  //   FlutterOverlayWindow.showOverlay(
  //       height: 500,
  //       width: 500,
  //       //enableDrag: true,
  //       //to enable dragging te window
  //       flag: OverlayFlag.focusPointer
  //       // to be able to input using keyboard and press the buttons
  //       );
  //   //finally worked <_*
  //   Get.find<TranslationController>().controller1.text = sharedMedia[0].path;
  //   Get.find<TranslationController>().enTranslate();
  //   Get.find<TranslationController>().update();
  //   print("${sharedMedia[0].path}printed))::");
  // } else {
  //the next code is to make only the overlay window run when the user shares
  //a text

  //I moved initializing a QuizController down here, to delay it a little bit, 'til the
  // DbController is initiated and has loaded the data to its variables.  And it is working :)
  // Get.put(QuizController());
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: permissionsAailable ? HomePage() : PermissionsPage()));
}
//}

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() async {
  //NOTE: this function runs only once, not every time the overlay is shown.
  WidgetsFlutterBinding.ensureInitialized();
  //It is an isolate, it is isolated from other threads, so it needs its own
  // dbController and other controllers.
  final DbController db = Get.put(DbController(),
      permanent: true); //permenant:true <=> stays in memory
  Get.put(TranslationController(db), permanent: true);
  Get.put(OverlayWindowController());
  // wait few seconds until the db finishes initializing (all the functions in its onInit() perform their jobs)
  // before calling QuizPage and Translate Page and Review Page later, which need the variables of dbController to be initialized
  // and loaded with data.
  await Future.delayed(Duration(seconds: 3));
  // Get.put(QuizController());
  runApp(
      GetMaterialApp(debugShowCheckedModeBanner: false, home: OverlayWindow()));
}
