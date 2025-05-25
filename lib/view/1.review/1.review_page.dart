import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/1.homecontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/1.review/2.stories_list_page.dart';

class ReviewPage extends GetView<HomeController> {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.find();

    return Container(
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
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLanguageCard(
                context,
                title: "Learn English",
                imagePath: "assets/images/uk_flag.png",
                textColor: AppColors.white,
                backgroundColor: AppColors.red2,
                onPressed: () {
                  dbController.changeLanguage('english');
                  Get.to(StoriesListPage());
                },
              ),
              const SizedBox(height: 30),
              _buildLanguageCard(
                context,
                title: "Learn German",
                imagePath: "assets/images/german_flag.png",
                textColor: Colors.orangeAccent,
                backgroundColor: AppColors.red2,
                onPressed: () {
                  dbController.changeLanguage('german');
                  Get.to(StoriesListPage());
                },
              ),
              const SizedBox(height: 30),
              _buildLanguageCard(
                context,
                title: "Snaps Review",
                imagePath: "assets/images/saved_snap.png",
                textColor: AppColors.yellow,
                backgroundColor: AppColors.red2,
                onPressed: () {
                  dbController.changeLanguage('german');
                  Get.to(StoriesListPage());
                },
              ),
            //   const SizedBox(height: 30),
            // // SizedBox(),
            // SizedBox(
            //   width: context.width / 1.1,
            //   height: context.height / 20,
            //   child: ElevatedButton(
            //     onPressed: () async{
            //         print("trying to show overlay window");
            //         await FlutterOverlayWindow.showOverlay(
            //             overlayTitle: "Overlay",
            //             overlayContent: "Monitoring App",
            //             enableDrag: true,
            //             flag: OverlayFlag.focusPointer);
            //     },
            //     style: ButtonStyle(
            //         backgroundColor: WidgetStatePropertyAll(Colors.grey),
            //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(7)))),
            //     child: Text(
            //       "Show Overlay Window",
            //       style: TextStyle(fontSize: 18, color: Colors.black),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: context.width / 1.1,
              height: context.height / 20,
              child: ElevatedButton(
                onPressed: () {
                  //Get.to(ReceiveSharingIntentPage());
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)))),
                child: Text(
                  "Receive sharing intent page",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context, {
    required String title,
    required String imagePath,
    required Color textColor,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.14,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
