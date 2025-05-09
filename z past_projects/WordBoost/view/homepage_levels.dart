import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup/control/dbcontroller.dart';
import 'package:wordup/model/appcolors.dart';
import 'package:wordup/view/storieslistpage.dart';

class Levels extends StatelessWidget {
  Levels({super.key});
  static const List<String> levels = ["Easy", "Intermediate", "Hard"];
  final DbController controller = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: levels
          .map((level) => Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SizedBox(
                    width: screenWidth,
                    height: 0.2 * screenHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          backgroundColor: AppColors.secondColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        level,
                        style: const TextStyle(
                            fontSize: 30, color: AppColors.firstColor),
                      ),
                      onPressed: () {
                        controller.changeLevel(levels.indexOf(level) + 1);
                        Get.to(StoriesListPage());
                      },
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
