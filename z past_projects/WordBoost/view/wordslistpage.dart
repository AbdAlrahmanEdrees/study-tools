import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/dbcontroller.dart';
import 'package:wordup/model/appcolors.dart';

class WordsListPage extends StatelessWidget {
  WordsListPage({super.key});
  final DbController controller = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.firstColor,
        appBar: AppBar(
          title: const Text(
            "Words List",
            style: TextStyle(fontSize: 25, color: AppColors.firstColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondColor,
          iconTheme: const IconThemeData(color: AppColors.firstColor),
        ),
        body: Obx(() {
          if (controller.words.isEmpty) {
            return const Center(child: Text("No Words the DB"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.words.length,
              itemBuilder: (context, index) {
                final word = controller.words[index];
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
                          child: Row(
                            children: [
                              Expanded(flex: 1,child: Text('${word['english']}')),
                              Expanded(flex: 1,child: Text(' ${word['arabic']}')),
                              // const Expanded(flex: 1,child: SizedBox()),
                              Expanded(flex: 1,child: Text(' no. of reviews: ${word['no_of_reviews']}')),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              controller.deleteWord(word['english']);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                );
              },
            );
          }
        }));
  }
}
