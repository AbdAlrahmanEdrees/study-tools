import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';
import 'package:studytools/control/3.monitoring/4.overlay_window_controller.dart';
import 'package:studytools/model/appcolors.dart';

class ReceiveSharingIntentPage extends GetView<OverlayWindowController> {
  ReceiveSharingIntentPage({super.key});
  final TranslationController _translationController =
      Get.find<TranslationController>();
  // final OverlayWindowController controller = Get.find<OverlayWindowController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // We will later put this page inside the overlay window, and exactly inside the Column widget of the overlay window
        // And widgets like Column has unbounded hight, so when you put a scaffold (a widget that requires a finite size) with unbounded hight inside a column which has
        // unbounded hight there's gonna be an error
        // also you can't put widgets that requires a finite size like ListView, Scaffold or Stack inside a widget of unbounded hight.
        height: context.height * 0.7,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.red3,
                AppColors.red3,
                Colors.red.shade600,
                Colors.red.shade500,
                Colors.red.shade500,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade500,
                Colors.red.shade500,
                Colors.red.shade600,
                AppColors.red3,
                AppColors.red3,
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
                  children: [
                    // if (controller.sharedText.value)
                    //   Text(
                    //     'Shared Text: ${controller.sharedSnaps[0]['type']}  ${controller.sharedSnaps[0]['path']}',
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          controller.saveSnaps();
                          // print(controller.sharedImagesAndVideos);
                        },
                        child: Text("save snaps")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       controller.savedFiles();
                    //       // print(controller.sharedImagesAndVideos);
                    //     },
                    //     child: Text("show saved files")),
                    if (controller.savedSuccessfully.value)
                      const Text(
                        "saved",
                        style: TextStyle(color: Colors.green),
                      ),
                    SizedBox(height: 20),
                    Expanded(
                      // If in the first shared intent (after running the bg service)
                      // the content of the page was 'p' (the default element of the sharedSnaps list in the controller)
                      // you can wrap the listview in a GetBuilder and update() after each intent receiving.
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.sharedSnaps.length,
                        itemBuilder: (context, index) {
                          final snap = controller.sharedSnaps[index];
                          if (snap['type'] == 'text') {
                            // return controller.textSnapWidget(index, context);
                            return textSnapWidget(index, context, controller,
                                _translationController);
                          } else if (snap['type'] == 'url') {
                            return urlSnapWidget(snap['path']);
                          } else {
                            return imageAndVideoSnapWidget(snap['path']);
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}

Widget imageAndVideoSnapWidget(String path) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.perm_media_rounded),
      title: Text(path),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}

Widget urlSnapWidget(String path) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.link),
      title: Text(path),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}

Widget textSnapWidget(
    int snapIndex,
    BuildContext context,
    OverlayWindowController overlayWindowController,
    TranslationController translationController) {
  TextEditingController textEditingController = TextEditingController();
  textEditingController.text =
      overlayWindowController.sharedSnaps[snapIndex]['path'];
  return Column(children: [
    Obx(
      () => ListTile(
          leading: Icon(Icons.note),
          title: overlayWindowController.editingTheSharedText.value == false
              ? RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.8,
                      letterSpacing: 0.4,
                    ),
                    children: translationController.buildTextSpans(
                        context,
                        overlayWindowController.sharedSnaps[snapIndex]['path'],
                        -1),
                  ),
                )
              : TextField(
                  controller: textEditingController,
                  minLines: 2,
                  maxLines: 10,
                ),
          trailing: overlayWindowController.editingTheSharedText.value == false
              ? IconButton(
                  onPressed: () {
                    overlayWindowController.editingTheSharedText.value = true;
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () {
                    overlayWindowController.sharedSnaps[snapIndex]['path'] =
                        textEditingController.text;
                    overlayWindowController.editingTheSharedText.value = false;
                  },
                  icon: Icon(Icons.assignment_turned_in_rounded))),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}
