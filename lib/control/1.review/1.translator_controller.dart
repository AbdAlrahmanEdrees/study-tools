// import 'package:flutter/gestures.dart';
// import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'package:studytools/control/dbcontroller.dart';
// import 'package:studytools/model/appcolors.dart';

class TranslationController extends GetxController {
  final DbController dbController;
  TranslationController(this.dbController);
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  // final DbController dbController = Get.find();
  String word = "input";
  String translation = "translation";
  RxString sourceLanguage = "english".obs;
  late final OnDeviceTranslator enTranslator;
  late final OnDeviceTranslator deTranslator;
  late final LanguageIdentifier languageIdentifier;

  @override
  void onInit() {
    super.onInit();
    enTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.arabic,
    );
    deTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.german,
      targetLanguage: TranslateLanguage.english,
    );
    languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.01);

    ///////////////////////////         Receiving shared intent

    // Listen to media sharing coming from outside the app while the app is in the memory.
    // _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
    //   _sharedFiles.clear();
    //   _sharedFiles.addAll(value);
    //   if (!_isTextFile(value[0])) {
    //     return;
    //   }
    //   print(controller1.text);
    //   controller1.text = "HI";

    //   FlutterOverlayWindow.showOverlay(
    //       height: 500,
    //       width: 500,
    //       //enableDrag: true,
    //       //to enable dragging te window
    //       flag: OverlayFlag.focusPointer
    //       // to be able to input using keyboard and press the buttons
    //       );
    //   Get.find<TranslationController>().controller1.text = value[0].path;
    //   Get.find<TranslationController>().update();
    //   print("${value[0].path}printed))::");
    //   ReceiveSharingIntent.instance.reset();
    // });

    // // Get the media sharing coming from outside the app while the app is closed.
    // ReceiveSharingIntent.instance.getInitialMedia().then((value) {
    //   _sharedFiles.clear();
    //   _sharedFiles.addAll(value);
    //   if (!_isTextFile(value[0])) {
    //     return;
    //   }
    //   print(controller1.text);
    //   controller1.text = "HI";

    //   FlutterOverlayWindow.showOverlay(
    //       height: 500,
    //       width: 500,
    //       //enableDrag: true,
    //       //to enable dragging te window
    //       flag: OverlayFlag.focusPointer
    //       // to be able to input using keyboard and press the buttons
    //       );
    //   Get.find<TranslationController>().controller1.text = value[0].path;
    //   Get.find<TranslationController>().update();
    //   print("${value[0].path}printed))::");

    //   // Tell the library that we are done processing the intent.
    //   ReceiveSharingIntent.instance.reset();
    // });
  }

  // bool _isTextFile(SharedMediaFile value) {
  //   // Simple check to verify if the received text is a text file.
  //   return value.type == SharedMediaType.text;
  // }

  String refineText(String text) {
    //replace every thing in the text that is NOT a character with a ' ' space.
    text = text.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    return text;
  }

  void enTranslate() async {
    final translatedText = await enTranslator.translateText(controller1.text);
    print("Translated Text: $translatedText");
    translation = translatedText;
    controller2.text =
        translatedText; // Set the translated text to the TextField
    sourceLanguage.value = "English";
    dbController.changeLanguage('english');
    update();
  }

  void deTranslate() async {
    final translatedText = await deTranslator.translateText(controller1.text);
    print("Translated Text: $translatedText");
    translation = translatedText;
    controller2.text =
        translatedText; // Set the translated text to the TextField
    sourceLanguage.value = "German";
    dbController.changeLanguage('german');
    update();
  }

  void detectLanguage(String text) async {
    //this function called onTextChanged
    //here call the Language Detector
    final List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(text);
    bool containsEnglish =
        possibleLanguages.any((lang) => lang.languageTag == 'en');
    bool containsGerman =
        possibleLanguages.any((lang) => lang.languageTag == 'de');

    if (containsGerman) {
      deTranslate();
    } else if (containsEnglish) {
      enTranslate();
    } else {
      return;
    }
  }

  void translateText() {
    // we will use this function temporarily (for semesterian only)
    if (sourceLanguage == "English") {
      enTranslate();
    } else if (sourceLanguage == "German") {
      deTranslate();
    }
  }

  @override
  void onClose() {
    enTranslator.close(); // Close the translator when done
    deTranslator.close();
    // _intentSub.cancel();
    super.onClose();
  }

  void translationCard(BuildContext context, String word, int storyId) {
    word = word.replaceAll(RegExp(r'[^a-zA-Z\-]'), '');
    controller1.text = word;
    translateText();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade400,
            content: SizedBox(
              height: context.height / 2.5,
              width: context.width / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () {
                          // print("closed");
                          // FlutterOverlayWindow.closeOverlay();
                          Get.back();
                          controller1.text = "";
                          controller2.text = "";
                          // FlutterOverlayWindow.disposeOverlayListener();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ]),
                  TextField(
                    style: TextStyle(color: AppColors.dark),
                    controller: controller1,
                    onChanged: (value) {
                      translateText();
                    },
                  ),
                  GetBuilder<TranslationController>(
                    //to be able to update the new translation when
                    //the user changes the first TextField
                    //init: TranslationController(),
                    builder: (controller) => TextField(
                      style: TextStyle(color: AppColors.dark),
                      controller: controller2,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                enTranslate();
                              },
                              child: Text("English")),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                deTranslate();
                              },
                              child: Text("German")),
                        )
                      ]),
                  SizedBox(
                    height: context.height / 30,
                  ),
                  Row(
                    children: [
                      Obx(() => Expanded(
                            child: Text(
                              sourceLanguage.value,
                              style: TextStyle(color: AppColors.dark),
                            ),
                          )),
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            dbController.addWord(
                                controller1.text, controller2.text, storyId);
                          },
                          child: const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                  // MaterialButton(
                  //   color: Theme.of(context).primaryColor,
                  //   onPressed: () => Get.back(),
                  //   child: const Text("Cancel"),
                  // )
                ],
              ),
            ),
          );
        });
  }

  List<TextSpan> buildTextSpans(
      BuildContext context, String text, int storyId) {
    //This function creates a span out of each word of the story text
    //this span detects the word when it is double-tapped
    List<TextSpan> spans = [];
    text.split(' ').forEach((word) {
      spans.add(TextSpan(
          text: '$word ',
          style: const TextStyle(color: AppColors.dark, fontSize: 16),
          recognizer:
              DoubleTapGestureRecognizer() //ther is a TapGestureRecognizer "..onTap=(){}"
                //and obviously a DoubleTapGestureRecognizer
                ..onDoubleTap = () {
                  translationCard(context, word, storyId);
                }));
    });
    return spans;
  }
}
