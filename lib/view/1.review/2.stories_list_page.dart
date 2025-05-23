import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/1.review/3.story_page.dart';
import 'package:studytools/view/1.review/4.add_story_page.dart';
import 'package:studytools/view/1.review/5.words_list_page.dart';
import 'package:studytools/view/1.review/6.quiz_page.dart';

class StoriesListPage extends StatelessWidget {
  StoriesListPage({super.key});
  final DbController controller = Get.put(DbController());

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 223, 73, 73),
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
        bottomNavigationBar: Container(
          height: 70,
          color: AppColors.red1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(WordsListPage());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.format_list_bulleted, color: Colors.white),
                      SizedBox(height: 4),
                      Text("Words",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(QuizPage());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.question_answer, color: Colors.white),
                      SizedBox(height: 4),
                      Text("Quiz",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.stories.isEmpty) {
            return const Center(
              child: Text(
                "No Stories in the DB",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.stories.length,
              itemBuilder: (context, index) {
                final story = controller.stories[index];
                return Dismissible(
                  key: Key(story['id'].toString()),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    controller.deleteStory(story['id']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox( 
                      height: 90,     
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: levelColor(story['story_level']),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        onPressed: () {
                          Get.to(StoryPage(
                            title: story['title'],
                            text: story['text'],
                            storyId: story['id'],
                          ));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: ListTile(
                                leading: const Icon(Icons.book, color: Colors.white, size: 28),
                                title: Text(
                                  story['title'],
                                  style: const TextStyle(
                                    fontSize: 20, 
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(AddStoryPage(
                                  level: story['story_level'],
                                  title: story['title'],
                                  text: story['text'],
                                  id: story['id'],
                                  action: "edit",
                                ));
                              },
                              icon: const Icon(Icons.edit, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
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
