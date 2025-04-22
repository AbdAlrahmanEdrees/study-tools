import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/model/appcolors.dart';

class MainBody extends StatelessWidget {
  final double iconSize = 48;

  const MainBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 204, 17, 17),
        // color: Colors.black,
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
            AppColors.red3
            // Color(0xFFCB2611),
            // Colors.red,
            // Color(0xFFCB2611),
            // HSVColor.fromColor(Colors.red).toColor(),
            // HSVColor.fromColor(Colors.red).toColor(),
            // HSVColor.fromColor(Colors.red).toColor(),
            // HSVColor.fromColor(AppColors.red2).toColor(),
            // HSVColor.fromColor(AppColors.yellow).toColor(),
            // HSVColor.fromColor(AppColors.red2).toColor(),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: context.height / 8,
            left: context.width / 2 - iconSize / 2,
            child: Icon(
              Icons.arrow_drop_up,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
