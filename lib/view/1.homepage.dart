import 'package:flutter/material.dart';
import 'package:studytools/control/1.homecontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:get/get.dart';
import 'package:studytools/view/0.widgets/2.home_page_drawer.dart';
import 'package:studytools/view/1.review/1.review_page.dart';
import 'package:studytools/view/2.pomodoro/1.pomodoropage.dart';
import 'package:studytools/view/3.stats/1.statspage.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  @override
  final HomeController controller = Get.put(HomeController());
  final List<Widget> pages = [StatsPage(), ReviewPage(), PomodoroPage()];
  @override
  Widget build(BuildContext context) {
    return
        //  GetBuilder<HomeController>(
        //     //the title, the BottomNavigationBar, and the body of the scaffold
        //     //need to be updated when the user travel between the BottomNavigation-buttons
        //     init: HomeController(),
        //     builder: (controller) =>
        Scaffold(
            backgroundColor: AppColors.red3,
            appBar: AppBar(
              // leading: Visibility(
              //     visible: controller.backButtonVisibility,
              //     child: IconButton(
              //         onPressed: () {
              //           controller.Page = ReviewPage();
              //           controller.backButtonVisibility = false;
              //           controller.update();
              //         },
              //         icon: Icon(Icons.arrow_back))),
              title: Obx(
                () => Text(
                  controller.title.value,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColors.red1,
            ),
            drawer: HomeDrawer(),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.index.value,
                fixedColor: AppColors.cyan,
                backgroundColor: AppColors.red1,
                onTap: (int newIndex) {
                  controller.bottomNavigation(newIndex);
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart_outlined),
                      label: "Statistics"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.reviews_outlined), label: "Review"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.timer_outlined), label: "Pomodoro"),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.question_mark_outlined), label: "P"),
                ],
              ),
            ),
            body: Obx(() => pages[controller.index.value]));
    // this is a creative way to make one bottom navigation bar for the different main pages
  }
}
