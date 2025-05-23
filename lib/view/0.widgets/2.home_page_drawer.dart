import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:studytools/control/1.homecontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/3.select_apps_to_monitor_page.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: AppColors.red3,
      child: Column(
        children: [
          SizedBox(height: screenHeight / 25),
          SizedBox(
              height: screenHeight / 6,
              width: 500,
              child: Image.asset(
                'assets/images/app_logo.png',
              )),
          SizedBox(
            height: screenHeight / 25,
          ),
          GestureDetector(
              onTap: controller.toggleBackGroundServiceSlider,
              child: ListTile(
                leading: Text(
                  "Background Service Activation",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Obx(() => _animatedSlider(controller)),
              )),
          SizedBox(height: screenHeight/20,),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text(" Add Apps to Monitor "),
            onTap: () {
                  Get.to(SelectAppsToMonitor());},
          ),
          const Expanded(child: SizedBox()),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Aboud Us"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _animatedSlider(HomeController controller) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
      width: 45,
      height: 18,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: controller.backGroundServiceOn.value
                  ? Colors.green
                  : Colors.grey,
              width: 2),
          borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 50),
            //curve: Curves.easeInOut,
            left: controller.backGroundServiceOn.value ? 24 : 2,
            top: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: controller.backGroundServiceOn.value
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
