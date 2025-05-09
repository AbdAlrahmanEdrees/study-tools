import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/view/select_apps_to_monitor.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(SelectAppsToMonitor());
                },
                child: Text("Add Apps To Monitor")),
                ElevatedButton(onPressed: ()async{
                  await FlutterOverlayWindow.showOverlay(
            overlayTitle: "Overlay",
            overlayContent: "Monitoring App",
            //enableDrag: true,
            flag: OverlayFlag.focusPointer
          );
                }, child: Text("show overlay window"))
          ],
        ),
      ),
    );
  }
}
