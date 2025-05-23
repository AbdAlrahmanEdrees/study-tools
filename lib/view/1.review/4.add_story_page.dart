import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:flutter/services.dart';

class AddStoryPage extends StatelessWidget {
  final String title, text, action;
  final int id, level;
  AddStoryPage(
      {super.key,
      this.level = 1,
      this.title = "",
      this.text = "",
      this.id = 1,
      this.action = "add"});

  final DbController controller = Get.find();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller1.text = title;
    controller2.text = text;
    final RxInt storyLevel = level.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.red1,
        title: Text(
          action == "add" ? "Add New Story" : "Edit Story",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
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
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card with a gradient color inside the card itself
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF800000), // Burgundy
                          Color(0xFF9B111E), // Wine Red
                          Color(0xFF800020) // Dark Burgundy
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Story Title TextField
                        TextField(
                          controller: controller1,
                          decoration: const InputDecoration(
                            labelText: "Story Title",
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 30,
                          style: const TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // Story Level Text
                        Obx(() => Text(
                              'Story Level: ${storyLevel.value}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Obx(() => Slider(
                              value: storyLevel.value.toDouble(),
                              min: 1,
                              max: 3,
                              divisions: 2,
                              label: storyLevel.value.toString(),
                              activeColor: AppColors.red1,
                              onChanged: (value) {
                                controller.level.value = value.toInt();
                                storyLevel.value = value.toInt();
                              },
                            )),
                        const SizedBox(height: 10),
                        // Story TextField
                        TextField(
                          controller: controller2,
                          decoration: const InputDecoration(
                            labelText: "Story Text",
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          minLines: 16,
                          maxLines: 20,
                          style: const TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'''[0-9a-zA-Z!@#$%^&*(),.?"'+:{}|<>_+~`=;\[\] \-\\/ ]+''')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (action == "add") {
                      controller.addStory(controller1.text, controller2.text);
                    } else {
                      controller.editStory(
                          controller1.text, controller2.text, id);
                    }
                  },
                  icon: Icon(action == "add" ? Icons.add : Icons.edit),
                  label: Text(
                    action == "add" ? "Add Story" : "Update Story",
                    style: const TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red1,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
