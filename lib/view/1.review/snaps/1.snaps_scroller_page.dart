import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';
import 'package:studytools/control/2.snapscontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/1.review/snaps/2.review_today_list.dart';
import 'package:studytools/view/1.review/snaps/3.all_snaps_list.dart';

class SnapsScrollerPage extends StatelessWidget {
  final bool backButtonVisibility;
  const SnapsScrollerPage({super.key, this.backButtonVisibility = true});
  @override
  Widget build(BuildContext context) {
    SnapsController controller = Get.put(SnapsController());
    TranslationController translationController =
        Get.find<TranslationController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Obx(
          () => ListTile(
            title: InkWell(
              onTap: () {
                Get.to(ReviewTodaySnapsList());
              },
              child: Column(
                children: [
                  Text(
                    "Today's Review",
                    style: GoogleFonts.poppins(
                        color: AppColors.dark, fontWeight: FontWeight.w600),
                  ),
                  LinearProgressIndicator(
                    value: controller.reviewingProgression.value,
                    color: AppColors.dark,
                    backgroundColor: Colors.white30,
                    minHeight: 8,
                  ),
                ],
              ),
            ),
            trailing: InkWell(
              onTap: () {
                controller.editingTextSnap.value = false;
                Get.to(AllSnapsListPage());
              },
              child: SizedBox(
                width: 20,
                child: Text(
                  '${controller.allSnaps.length}',
                  style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.red1,
        leading: Visibility(
          visible: backButtonVisibility,
          child: IconButton(
            onPressed: () {
              Get.delete<SnapsController>(force: true);
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
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
          child: GetBuilder<SnapsController>(builder: (cntroller) {
            if (cntroller.userShouldWait.value) {
              return Center(child: CircularProgressIndicator());
            } else if (cntroller.noSnapsToReviewToday.value) {
              return Center(
                child: Text("No Snaps To Review Today"),
              );
            } else if (cntroller.todaySnapsWidgets[cntroller.snapIndex.value]
                is Widget) {
              return cntroller.todaySnapsWidgets[cntroller.snapIndex.value];
            } else {
              return textSnapWidget(
                  controller.todaySnapsWidgets[controller.snapIndex.value],
                  context,
                  controller,
                  translationController);
            }
          })),
    );
  }
}

Widget textSnapWidget(
    String noteContent,
    BuildContext context,
    SnapsController snapsController,
    TranslationController translationController) {
  TextEditingController textEditingController = TextEditingController();
  textEditingController.text = noteContent;
  return GestureDetector(
    onVerticalDragUpdate: (details) {
      if (details.delta.dy > 0) {
        snapsController.editingTextSnap.value = false;
        snapsController.snapIndex.value++;
        ///////////"⬇️ User slid down");
        // onSlideDown();
      } else if (details.delta.dy < 0) {
        snapsController.editingTextSnap.value = false;
        snapsController.snapIndex.value--;
        ////////////"⬆️ User slid up");
        // onSlideUp();
      }
    },
    child: Obx(
      () => ListTile(
          leading: Icon(Icons.note),
          title: snapsController.editingTextSnap.value == false
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
                        context, noteContent, -1),
                  ),
                )
              : TextField(
                  controller: textEditingController,
                  minLines: 2,
                  maxLines: 10,
                ),
          trailing: snapsController.editingTextSnap.value == false
              ? IconButton(
                  onPressed: () {
                    snapsController.editingTextSnap.value = true;
                  },
                  icon: Icon(Icons.edit))
              : IconButton(
                  onPressed: () {
                    // we will update the Db here
                    // to avoid refreshing the whole todaySnaps list
                    // we will edit both of it and the db
                    snapsController.todaySnapsWidgets[snapsController
                        .snapIndex.value] = textEditingController.text;
                    Get.find<DbController>().updateNoteSnap(
                        snapsController
                            .todaySnaps[snapsController.snapIndex.value]['id'],
                        textEditingController.text);
                    snapsController.editingTextSnap.value = false;
                  },
                  icon: Icon(Icons.assignment_turned_in_rounded))),
    ),
  );
}
