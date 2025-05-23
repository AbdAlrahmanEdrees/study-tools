import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/control/1.review/1.translator_controller.dart';

class StoryPage extends StatelessWidget {
  final String title, text;
  final int storyId;
  StoryPage(
      {super.key,
      required this.title,
      required this.text,
      required this.storyId});
  final TranslationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.red1,
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 134, 19, 19),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("No Story", style: TextStyle(fontSize: 18)),
            onPressed: () => Get.back(),
          ),
        ),
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black45,
                offset: Offset(1, 1),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.red3,
              Colors.red.shade600,
              Colors.red.shade500,
              Colors.red.shade400,
              Colors.red.shade500,
              Colors.red.shade600,
              AppColors.red3,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.8,
                      letterSpacing: 0.4,
                    ),
                    children: controller.buildTextSpans(context, text, storyId),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
