import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';
import 'package:studytools/control/2.snapscontroller.dart';
import 'package:studytools/model/appcolors.dart';

class AllSnapsListPage extends StatelessWidget {
  const AllSnapsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    SnapsController controller = Get.find<SnapsController>();
    TranslationController translationController =
        Get.find<TranslationController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.red2,
          title: Text("All Snaps Page"),
          centerTitle: true,
        ),
        body: Container(
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
            child: controller.allSnaps.isEmpty
                ? Center(
                    child: Text(
                        "You didn't add any snap yet\n Try share pictures/videos/text/urls to the app\nto add them as snaps"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() => ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.allSnaps.length,
                          itemBuilder: (context, index) {
                            final snap = controller.allSnaps[index];
                            if (snap['type'] == 'text') {
                              // return controller.textSnapWidget(index, context);
                              return textSnapWidget(index, context, controller,
                                  translationController);
                            } else if (snap['type'] == 'url') {
                              return urlSnapWidget(snap['path']);
                            } else {
                              return imageAndVideoSnapWidget(snap['path']);
                            }
                          },
                        )),
                  )));
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
    int index,
    BuildContext context,
    SnapsController snapscontroller,
    TranslationController translationController) {
  TextEditingController textEditingController = TextEditingController();
  textEditingController.text = snapscontroller.allSnaps[index]['snap'];
  return Column(children: [
    Obx(
      () => ListTile(
          leading: Icon(Icons.note),
          title: snapscontroller.editingTextSnap.value == false
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
                        context, snapscontroller.allSnaps[index]['snap'], -1),
                  ),
                )
              : TextField(
                  controller: textEditingController,
                  minLines: 2,
                  maxLines: 10,
                ),
          trailing: snapscontroller.editingTextSnap.value == false
              ? IconButton(
                  onPressed: () {
                    snapscontroller.editingTextSnap.value = true;
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () {
                    snapscontroller.allSnaps[index]['snap'] =
                        textEditingController.text;
                    Get.find<DbController>().updateNoteSnap(
                        snapscontroller.allSnaps[index]['id'],
                        textEditingController.text);
                    snapscontroller.editingTextSnap.value = false;
                  },
                  icon: Icon(Icons.assignment_turned_in_rounded))),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}
