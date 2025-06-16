import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';

class SnapsController extends GetxController {
  final DbController _dbController = Get.find<DbController>();
  final TranslationController _translationController =
      Get.find<TranslationController>();
  RxInt snapIndex = 0.obs;
  double reviewdSnapsCounter = 0;
  // The remaining snaps in the today's-should-review snaps
  RxInt remainingSnaps = 0.obs;
  RxDouble reviewingProgression = 0.0.obs;
  late double todaySnapsCount;
  RxList todaySnaps = [].obs;
  RxList allSnaps = [].obs;
  RxList todaySnapsWidgets = <Widget>[].obs;
  RxBool userShouldWait = true.obs;
  RxBool noSnapsToReviewToday = false.obs;
  RxBool editingTextSnap = false.obs;
  late var context;
  @override
  void onInit() async {
    super.onInit();
    await _dbController.selectSnaps();
    await _dbController.updateToReviewTodaySnaps();
    todaySnaps = _dbController.toReviewTodaySnaps;
    allSnaps = _dbController.snaps;
    todaySnapsCount = todaySnaps.length.toDouble();
    if (todaySnapsCount == 0) {
      userShouldWait.value = false;
      noSnapsToReviewToday.value = true;
      return;
    }
    noSnapsToReviewToday.listen(
      (p0) {
        update();
      },
    );
    userShouldWait.listen(
      (p0) {
        update();
      },
    );
    userShouldWait.value = false;
    initializeSnapsWidgets();
  }

  void initializeSnapsWidgets() {
    for (int i = 0; i < todaySnapsCount; i++) {
      if (i == 0) update();
      todaySnapsWidgets.add(Center());
    }
  }

  Widget imageSnapWidget(String path) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            editingTextSnap.value = false;
            ///////////"⬇️ User slid down");
            // onSlideDown();
          } else if (details.delta.dy < 0) {
            editingTextSnap.value = false;
            ////////////"⬆️ User slid up");
            // onSlideUp();
          }
        },
        child: Center(child: Image.file(File(path))));
  }

  Widget videoSnapWidget(String path) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            editingTextSnap.value = false;
            ///////////"⬇️ User slid down");
            // onSlideDown();
          } else if (details.delta.dy < 0) {
            editingTextSnap.value = false;
            ////////////"⬆️ User slid up");
            // onSlideUp();
          }
        },
        child: Center(
          child: ListTile(
            leading: Icon(Icons.perm_media_rounded),
            title: Text(path),
          ),
        ));
  }

  Widget urlSnapWidget(String path) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          editingTextSnap.value = false;
          ///////////"⬇️ User slid down");
          // onSlideDown();
        } else if (details.delta.dy < 0) {
          editingTextSnap.value = false;
          ////////////"⬆️ User slid up");
          // onSlideUp();
        }
      },
      child: Center(
        child: ListTile(
          leading: Icon(Icons.link),
          title: Text(path),
        ),
      ),
    );
  }
}
