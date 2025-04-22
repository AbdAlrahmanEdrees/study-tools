import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';
import 'package:studytools/control/3.flutter_background_service_utils.dart';
import 'package:studytools/model/sqldb.dart';
import 'package:studytools/view/1.homepage.dart';
import 'package:studytools/view/2.permissionspage.dart';
import 'package:studytools/view/0.widgets/1.overlay_widget.dart';
import 'package:usage_stats/usage_stats.dart';
// import 'package:studytools/view/1.wordboost/widgets/overlay_translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //without the previous line in the beginning, the app will not run, only a black screen
  //will show up, but after I just added this line, the app ran, first a window appeared
  //asking for 'overlay over apps' permission' :) and everything was perfectly fine.
  Get.put(TranslationController());

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



  // Get the media sharing coming from outside the app while the app is closed.
  // Get the media sharing coming from outside the app while the app is closed.

  final sharedMedia = await ReceiveSharingIntent.instance.getInitialMedia();

  if (sharedMedia.isNotEmpty && sharedMedia[0].type == SharedMediaType.text) {
    FlutterOverlayWindow.showOverlay(
        height: 500,
        width: 500,
        //enableDrag: true,
        //to enable dragging te window
        flag: OverlayFlag.focusPointer
        // to be able to input using keyboard and press the buttons
        );
    //finally worked <_*
    Get.find<TranslationController>().controller1.text = sharedMedia[0].path;
    Get.find<TranslationController>().enTranslate();
    Get.find<TranslationController>().update();
    print("${sharedMedia[0].path}printed))::");
  } else {
    //the next code is to make only the overlay window run when the user shares
    //a text
    runApp(GetMaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        home:permissionsAailable? const HomePage() : PermissionsPage()));
  }
}

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TranslationController());
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(

          // child: Container(color: Colors.red, child: Text("My overlay")))));
          child: OverlayWidget())));
}
