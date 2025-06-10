import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';

class OverlayWindowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final animationIsRunning = true.obs;
  RxInt index = 0.obs;
  RxList sharedFiles = <SharedMediaFile>[].obs;
  RxString sharedText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    randomIndex();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          animationIsRunning.value = false;
          update();
        }
      });

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    FlutterOverlayWindow.overlayListener.listen(
      (event) {
        print("this is the event: $event");
        if (event is String) {
          if (event == 'reset_animation') {
            animationController.reset();
            animationController.forward();
          } else{
            sharedText.value=event;
          }
        } else if (event is int) {
          index.value = event;
        } else if (event is List) {
          sharedFiles.value = event;
        }
      },
    );

    animationController.forward();
  }

  void closingOverlay() async {
    FlutterOverlayWindow.closeOverlay();
    animationIsRunning.value = true;
    if (index.value == 1) //Quiz
    {
      if (index.value == 1) //Means Quiz
      {
        if (Get.find<DbController>().language.value == 'english') {
          Get.find<DbController>().changeLanguage('german');
        } else {
          Get.find<DbController>().changeLanguage('english');
        }
      }
      Get.delete<QuizController>(force: true);
    }

    randomIndex();
  }

  void randomIndex() {
    index.value = Random().nextInt(3); // it will be >=0 and <3}
  }


  
  void saveFiles() async {
    // sharedFiles.value.map((f)  {
    //   print(f.path);
    // });
    // print("you pressed the button nnnnnn");
    // Directory s = await getApplicationDocumentsDirectory();
    // print(s.path);
    final directory = await getExternalStorageDirectory();
    for (var i in sharedFiles) {
      if (directory != null) {
        // final name = i.path.split('/').last;
        // final newPath = '${directory.path}/$name';
        // final newFile = await File(i.path).copy(newPath);
        // print(newFile.path);
        // if (await directory.exists()) {
        //   final files = directory.listSync();
        //   print(files);
        final file = File(i.path);
        if (await file.exists()) {
          await file.delete();
          print("deleted successfully");
        }
      }
    }
  }
}
