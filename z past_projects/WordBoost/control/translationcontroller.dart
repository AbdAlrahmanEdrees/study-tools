import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:wordup/control/dbcontroller.dart';
import 'package:wordup/model/appcolors.dart';

class TranslationController extends GetxController {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  DbController db_controller = Get.put(DbController());
  String translation = "";
  late final OnDeviceTranslator onDeviceTranslator;

  @override
  void onInit() {
    super.onInit();
    onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.arabic,
    );
  }

  Future<void> translateText(String inputText) async {
    if (inputText.trim().isEmpty) {
      print("Input text is empty, skipping translation.");
      translation = "";
      controller2.text = "";
      update();
      return;
    }

    try {
      final translatedText = await onDeviceTranslator.translateText(inputText);
      print("Translated Text: $translatedText");
      translation = translatedText;
      controller2.text = translatedText;
    } catch (e) {
      print("Error during translation: $e");
      translation = "Translation error.";
      controller2.text = "Translation error.";
    }
    update();
  }

  @override
  void onClose() {
    onDeviceTranslator.close(); // Close the translator when done
    super.onClose();
  }

  void translationCard(BuildContext context, String word, int storyId) {
    word = word.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    translateText(word);
    controller1.text = word;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade400,
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: controller1,
                    onChanged: (value) {
                      translateText(value);
                    },
                  ),
                  GetBuilder<TranslationController>(
                    //to be able to update the new translation when
                    //the user changes the first TextField
                    init: TranslationController(),
                    builder: (controller) => TextField(
                      controller: controller2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          db_controller.addWord(
                              controller1.text, controller2.text, storyId);
                        },
                        child: const Text("Save"),
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      )
                    ],
                  )
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
    text.split(RegExp(r'[ \.]+')).forEach((word) {
      spans.add(TextSpan(
          text: ' $word ',
          style: const TextStyle(color: AppColors.fourthColor, fontSize: 16),
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
