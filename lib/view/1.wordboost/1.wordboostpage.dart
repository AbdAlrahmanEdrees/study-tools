import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/2.homecontroller.dart';
import 'package:studytools/view/1.wordboost/2.stories_list_page.dart';
import 'package:studytools/view/3.select_apps_to_monitor_page.dart';

class ReviewPage extends GetView<HomeController> {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.put(DbController());
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.height / 15,
          children: [
            Card(
              child: SizedBox(
                width: context.width / 1.2,
                height: context.height / 10,
                child: ElevatedButton(
                  onPressed: () {
                    dbController.changeLanguage('english');
                    Get.to(StoriesListPage());
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white54),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
                  child: Text(
                    "Learn English",
                    style: TextStyle(fontSize: 35, color: Colors.lightBlue),
                  ),
                ),
              ),
            ),
            SizedBox(),
            SizedBox(
              width: context.width / 1.2,
              height: context.height / 10,
              child: ElevatedButton(
                onPressed: () {
                  dbController.changeLanguage('german');
                  Get.to(StoriesListPage());
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)))),
                child: Text(
                  "Learn German",
                  style: TextStyle(fontSize: 35, color: Colors.deepOrange),
                ),
              ),
            ),
            SizedBox(),
            ElevatedButton(
                onPressed: () {
                  Get.to(SelectAppsToMonitor());
                },
                child: Text("Add Apps To Monitor")),
                ElevatedButton(onPressed: ()async{
                  await FlutterOverlayWindow.showOverlay(
            overlayTitle: "Overlay",
            overlayContent: "Monitoring App",
            enableDrag: true,
            flag: OverlayFlag.focusPointer
          );
                }, child: Text("show overlay window"))
            // SizedBox(
            //   width: context.width / 1.2,
            //   height: context.height / 10,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       SqlDb sqlDb = SqlDb();
            //       sqlDb.deleteDb();
            //     },
            //     style: ButtonStyle(
            //         backgroundColor: WidgetStatePropertyAll(Colors.grey),
            //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(7)))),
            //     child: Text(
            //       "See DB Words",
            //       style: TextStyle(fontSize: 35, color: AppColors.dark),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
