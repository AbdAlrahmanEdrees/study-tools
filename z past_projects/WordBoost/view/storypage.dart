import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/translationcontroller.dart';
import 'package:wordup/model/appcolors.dart';

class StoryPage extends StatelessWidget {
  final String title, text;
  final int storyId;
  StoryPage({super.key, required this.title, required this.text, required this.storyId});
  final TranslationController controller = Get.put(TranslationController());
  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Center(
          child: ElevatedButton(
        child: const Text("No Story"),
        onPressed: () {
          Get.back();
        },
      ));
    } else {
      return Scaffold(
        backgroundColor: AppColors.firstColor,
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(fontSize: 25, color: AppColors.firstColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondColor,
          iconTheme: const IconThemeData(color: AppColors.firstColor),
        ),
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                    text: TextSpan(
                        children: controller.buildTextSpans(context, text, storyId))),
              ),
            ],
          ),
        ),
      );
    }
  }
///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
}
