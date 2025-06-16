import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.review/2.quiz_controller.dart';

class OverlayWindowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DbController _dbController = Get.find<DbController>();
  // final TranslationController _translationController =
  //     Get.find<TranslationController>();
  late AnimationController animationController;
  late Animation<double> animation;
  late final Directory? directory;
  final animationIsRunning = true.obs;
  /////////////////// Receiving shared intent page /////////////////////
  RxBool savedSuccessfully = false.obs;
  RxBool editingTheSharedText = false.obs;
  RxList sharedSnaps = <Map<String, String>>[
    {'path': 'p', 'type': 't'}
  ].obs;
  // The following varialbes, are the variables responsible of forming the page
  // in the right form according to the type of the snap image&video or text&url
  RxInt overlayPagesIndex = 0.obs;
  RxInt snapWidgetIndex = 0.obs;
  RxInt snapIndex = 0.obs;
  late List<Widget> snapWidget;
  @override
  void onInit() async {
    super.onInit();
    randomIndex();
    directory = await getExternalStorageDirectory();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
            // } else {
            //   sharedText.value = event;
            //   // sharedFiles =
            //   //     [SharedMediaFile(path: 'path', type: SharedMediaType.file)].obs;
          }
          // } else if (event is int) {
          //   index.value = event;
          //   animationController.stop();
        } else if (event is List) {
          // !!! PROBLEM: Dart's isolate message passing doesn't preserve class types like SharedMediaFile.
          // anyhing that is not native will become a raw like List<dynamic> or Map<dynamic, dynamic>
          // sharedFiles.value = event;
          // var l = event as List<Map<String, String>>;
          // sharedText.value = false;
          animationIsRunning.value = false;
          overlayPagesIndex.value = 2;
          sharedSnaps = event.obs;
        } else if (event is Map) {
          animationIsRunning.value = false;
          overlayPagesIndex.value = 2;
          sharedSnaps = [event].obs;
          // sharedText.value = true;
        }
      },
    );

    // ////////////////////////////////// formatting the page according to the snap ////////////////
    // snapIndex.listen(
    //   (newValue) {
    //     if (sharedSnaps[newValue]['type'] == 'text') {
    //       snapWidgetIndex.value = 1;
    //     } else {
    //       snapWidgetIndex.value = 0;
    //     }
    //     update();
    //   },
    // );
    // animationController.forward();
  }

  void closingOverlay() async {
    FlutterOverlayWindow.closeOverlay();
    // sharedSnaps.clear();
    animationIsRunning.value = true;
    editingTheSharedText.value = false;
    savedSuccessfully.value = false;
    if (overlayPagesIndex.value == 1) //Quiz
    {
      if (overlayPagesIndex.value == 1) //Means Quiz
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
    overlayPagesIndex.value = Random().nextInt(3); // it will be >=0 and <3}
  }

  void saveSnaps() async {
    if (directory == null) return;
    for (var snap in sharedSnaps) {
      if (snap['type'] == 'image' || snap['type'] == 'video') {
        final fileName = snap['path'].split('/').last;
        final newPath = '${directory!.path}/$fileName';
        final newCopiedFile = await File(snap['path']).copy(newPath);
        print(newCopiedFile);
      }
      _dbController.addSnap(snap['path'], snap['type']);
    }
    savedSuccessfully.value = true;
  }

  void savedSnaps() async {
    /////////// To show the saved images and videos in the app directory:   /////////
    // if (directory != null) {
    //   sharedSnaps.clear();
    //   if (await directory!.exists()) {
    //     final files = directory!.listSync();
    //     for (var i in files) {
    //       print(i.path);
    //       sharedSnaps.add({'path': i.path, 'type': 'idk'});
    //     }
    //   }
    // }
    sharedSnaps.clear();
    for (var i in _dbController.snaps) {
      sharedSnaps.add({'path': i['snap'], 'type': i['type']});
    }
    print(
        "*************************** Shared Snaps            ***************************");
    print(sharedSnaps);
    print(
        "*************************** DB snaps            ***************************");
    print(_dbController.snaps);
  }

  void deleteImageOrVideoFile(String path) async {
    File fileToDelete = File(path);
    await fileToDelete.delete();
  }

  // Widget textSnapWidget(int snapIndex, BuildContext context) {
  //   TextEditingController textEditingController = TextEditingController();
  //   textEditingController.text = sharedSnaps[snapIndex]['path'];
  //   return Column(children: [
  //     Obx(
  //       () => ListTile(
  //           leading: Icon(Icons.file_copy),
  //           title: editingTheSharedText.value == false
  //               ? RichText(
  //                   textAlign: TextAlign.justify,
  //                   text: TextSpan(
  //                     style: const TextStyle(
  //                       fontSize: 18,
  //                       color: Colors.white,
  //                       height: 1.8,
  //                       letterSpacing: 0.4,
  //                     ),
  //                     children: _translationController.buildTextSpans(
  //                         context, sharedSnaps[snapIndex]['path'], -1),
  //                   ),
  //                 )
  //               : TextField(
  //                   controller: textEditingController,
  //                   minLines: 2,
  //                   maxLines: 10,
  //                 ),
  //           trailing: editingTheSharedText.value == false
  //               ? IconButton(
  //                   onPressed: () {
  //                     editingTheSharedText.value = true;
  //                   },
  //                   icon: Icon(Icons.edit))
  //               : IconButton(
  //                   onPressed: () {
  //                     sharedSnaps[snapIndex]['path'] =
  //                         textEditingController.text;
  //                     editingTheSharedText.value = false;
  //                   },
  //                   icon: Icon(Icons.assignment_turned_in_rounded))),
  //     ),
  //     const SizedBox(
  //       height: 20,
  //     )
  //   ]);
  // }
}
