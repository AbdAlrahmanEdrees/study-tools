import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/receive_sharing_intent/receive_intent_controller.dart';
import 'package:studytools/model/appcolors.dart';

class ReceiveSharingIntentPage extends StatelessWidget {
  ReceiveSharingIntentPage({super.key});
  final ReceiveSharingIntentController controller =
      Get.put(ReceiveSharingIntentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
