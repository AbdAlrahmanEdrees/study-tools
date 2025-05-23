import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';

class WordsListPage extends StatelessWidget {
  WordsListPage({super.key});
  final DbController controller = Get.find();

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
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade500,
            Colors.red.shade600,
            AppColors.red3,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Words List",
            style: TextStyle(fontSize: 25, color: AppColors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.red1,
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: Obx(() {
          if (controller.words.isEmpty) {
            return const Center(
              child: Text(
                "No Words in the DB",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.words.length,
              itemBuilder: (context, index) {
                final word = controller.words[index];
                final bgColor =
                    index % 2 == 0 ? AppColors.cyan : AppColors.dark;

                return Dismissible(
                  key: Key(word['word']),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    controller.deleteWord(word['word']);
                  },
                  child: Card(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  word['word'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  word['translation'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.yellow
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "No. of reviews: ${word['no_of_reviews']}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
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
}
