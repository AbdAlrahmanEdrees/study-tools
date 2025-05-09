import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/dbcontroller.dart';
import 'package:wordup/model/appcolors.dart';
import 'package:flutter/services.dart';

class AddStoryPage extends StatelessWidget {
  final String title, text, action;
  final int id;
  AddStoryPage(
      {super.key, this.title = "", this.text = "", this.id=1, this.action = "add"});
  //the default "" value, will give a chance to the hint text of
  //each of the upcoming  TextFields show up
  //espicially when adding a story
  final DbController controller = Get.put(DbController());
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller1.text = title;
    controller2.text = text;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.firstColor),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.firstColor,
      body: SingleChildScrollView(
        //this widget keeps the screen flexible with the keyboard popping up
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller1,
                decoration: const InputDecoration(hintText: "Story Title"),
                maxLength: 30,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.secondColor),
              ),
              Column(
                children: [
                  TextField(
                      controller: controller2,
                      decoration: const InputDecoration(
                        hintText: "Story Text",
                      ),
                      minLines: 2,
                      maxLines: 20,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.secondColor),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'''[0-9a-zA-Z!@#$%^&*(),.?"'+:{}|<>_+~`=;
                           \[\] \-\\/ ]+''')), // Allow all specified characters],
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (action == "add") {
                        controller.addStory(controller1.text, controller2.text);
                      } else {
                        controller.editStory(
                            controller1.text, controller2.text, id);
                      }
                    },
                    child: Text(
                      action,
                      style: const TextStyle(
                          color: AppColors.secondColor, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
