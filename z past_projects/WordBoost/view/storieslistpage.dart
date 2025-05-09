import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/dbcontroller.dart';
import 'package:wordup/model/appcolors.dart';
import 'package:wordup/view/addstorypage.dart';
import 'package:wordup/view/storypage.dart';

class StoriesListPage extends StatelessWidget {
  StoriesListPage({super.key});
  final DbController controller = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.firstColor,
      appBar: AppBar(
        title: const Text(
          "Stories List",
          style: TextStyle(fontSize: 25, color: AppColors.firstColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondColor,
        iconTheme: const IconThemeData(color: AppColors.firstColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddStoryPage());
        },
        backgroundColor: AppColors.fourthColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          if (controller.stories.isEmpty) {
            return const Center(child: Text("No Stories in the DB"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.stories.length,
              itemBuilder: (context, index) {
                final story = controller.stories[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: MaterialButton(
                    color: index % 2 == 0
                        ? AppColors.thirdColor
                        : AppColors.secondColor,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(story['title']),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(AddStoryPage(
                                        title: story['title'],
                                        text: story['text'],
                                        id: story['id'],
                                        action: "edit"));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                onPressed: () {
                                  controller.deleteStory(story['id']);
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Get.to(StoryPage(
                          title: story['title'], text: story['text'],
                          storyId: story['id'],));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
