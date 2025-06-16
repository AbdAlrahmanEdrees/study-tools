import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studytools/control/1.homecontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/3.select_apps_to_monitor_page.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: AppColors.red3,
      child: Column(
        children: [
          SizedBox(height: screenHeight / 25),
          SizedBox(
              // height: screenHeight / 6,
              width: 500,
              child: Image.asset(
                'assets/images/app_logo.png',
              )),
          SizedBox(
            height: screenHeight / 55,
          ),
          // IF the user is not signed in:
          controller.isSignedIn.value ? _profile() : _signInWithGoogleButton(),
          _profile(),
          SizedBox(
            height: screenHeight / 55,
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
          SizedBox(
            height: screenHeight / 20,
          ),
          // Obx(()=>Checkbox(value: value, onChanged: onChanged)),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text(" Add Apps to Monitor "),
            onTap: () {
              Get.to(SelectAppsToMonitor());
            },
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

  Widget _signInWithGoogleButton() {
    return SizedBox(
        width: 210,
        child: MaterialButton(
          onPressed: () {
            controller.signInWithGoogle();
          },
          color: const Color.fromARGB(255, 222, 214, 214),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in with Google",
                style: GoogleFonts.poppins(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'assets/images/google.png',
                width: 25,
              )
            ],
          ),
        ));
  }

  Widget _profile() {
    return InkWell(
        onTap: () {
          controller.signOut();
        },
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            "Sign Out",
            style: GoogleFonts.poppins(
                color: Colors.black87, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
