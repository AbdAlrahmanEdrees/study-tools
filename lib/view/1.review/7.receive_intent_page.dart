import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/3.monitoring/4.overlay_window_controller.dart';
import 'package:studytools/model/appcolors.dart';

class ReceiveSharingIntentPage extends GetView<OverlayWindowController> {
  const ReceiveSharingIntentPage({super.key});
  // final OverlayWindowController controller = Get.find<OverlayWindowController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // We will later put this page inside the overlay window, and exactly inside the Column widget of the overlay window
        // And widgets like Column has unbounded hight, so when you put a scaffold (a widget that requires a finite size) with unbounded hight inside a column which has
        // unbounded hight there's gonna be an error
        // also you can't put widgets that requires a finite size like ListView, Scaffold or Stack inside a widget of unbounded hight.
        height: context.height * 0.5,
        child: Scaffold(
          backgroundColor: AppColors.red4,
          appBar: AppBar(
            backgroundColor: AppColors.red3,
            title: Text("Receiving sharing Intent"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Obx(() => Text(
                      'Shared Text: ${controller.sharedText.value}',
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      controller.saveFiles();
                    },
                    child: Text("save file")),
                SizedBox(height: 20),
                Obx(() => Expanded(
                      child: ListView.builder(
                        itemCount: controller.sharedFiles.length,
                        itemBuilder: (context, index) {
                          final file = controller.sharedFiles[index];
                          return ListTile(
                            leading: Icon(Icons.insert_drive_file),
                            title: Text(file.path),
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
