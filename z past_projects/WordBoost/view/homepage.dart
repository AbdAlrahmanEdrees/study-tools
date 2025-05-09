import 'package:flutter/material.dart';
import 'package:wordup/control/homepagecontroller.dart';
import 'package:wordup/model/appcolors.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  //final ReadStory rs = const ReadStory();
  //final String title;
  //const Home({super.key,required this.title});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        //the title, the BottomNavigationBar, and the body of the scaffold
        //need to be updated when the user travel between the BottomNavigation-buttons
        init: HomeController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.firstColor,
            appBar: AppBar(
              title: Text(
                controller.title.value,
                style:
                    const TextStyle(fontSize: 25, color: AppColors.firstColor),
              ),
              centerTitle: true,
              backgroundColor: AppColors.secondColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              fixedColor: AppColors.fourthColor,
              backgroundColor: AppColors.secondColor,
              onTap: (int newIndex) {
                controller.changePage(newIndex);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books_outlined), label: "STORY"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.question_mark_outlined), label: "QUIZ"),
              ],
            ),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: controller.Page)));
    // this is a creative way to make one bottom navigation bar for the different main pages
  }
}
