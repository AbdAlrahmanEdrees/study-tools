import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/1.wordboost/4.add_story_page.dart';
import 'package:studytools/view/1.wordboost/3.story_page.dart';
import 'package:studytools/view/1.wordboost/5.words_list_page.dart';
import 'package:studytools/view/1.wordboost/6.quiz_page.dart';

class StoriesListPage extends StatelessWidget {
  StoriesListPage({super.key});
  final DbController controller = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      appBar: AppBar(
        title: const Text(
          "Stories List",
          style: TextStyle(
              fontSize: 25,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.red1,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddStoryPage());
        },
        backgroundColor: AppColors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.red),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.red1,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.library_books),
              onPressed: () {
                Get.to(WordsListPage());
              },
            ),
            IconButton(
              icon: Icon(Icons.quiz),
              onPressed: () {
                Get.to(QuizPage());
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          if (controller.stories.isEmpty) {
            return const Center(
                child: Text(
              "No Stories in the DB",
              style: TextStyle(fontSize: 20),
            ));
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
                    color: levelColor(story['story_level']),
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
                                        level: story['story_level'],
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
                        title: story['title'],
                        text: story['text'],
                        storyId: story['id'],
                      ));
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

  Color levelColor(int level) {
    switch (level) {
      case 1:
        return Colors.green.shade400;
      case 2:
        return Colors.blue.shade400;
      default:
        return Colors.red.shade400;
    }
  }
}
