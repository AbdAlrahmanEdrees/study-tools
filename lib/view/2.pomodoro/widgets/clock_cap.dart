import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/model/appcolors.dart';

class ClockCap extends StatelessWidget {
  final int barCount;
  final double progression;
  final double barWidth = 25;

  const ClockCap({
    super.key,
    required this.barCount,
    required this.progression,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height / 8,
      decoration: BoxDecoration(
          color: Colors.redAccent,
          gradient: LinearGradient(
            colors: [
              // HSVColor.fromColor(Color(0xFFCB2611)).withValue(0.5).toColor(),
              // HSVColor.fromColor(Color(0xFFCB2611)).withSaturation(0.7).toColor(),
              // HSVColor.fromColor(Color(0xFFCB2611)).withValue(0.5).toColor(),
              // HSVColor.fromColor(Colors.red).toColor(),
              // HSVColor.fromColor(Colors.red).toColor(),
              // HSVColor.fromColor(Colors.red).toColor()
            AppColors.red3,
            Colors.red.shade500,
            Colors.red.shade400,
            Colors.red.shade400,
            Colors.red.shade500,
            AppColors.red3
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]),
      child: FittedBox(
        alignment: Alignment.bottomLeft,
        fit: BoxFit.none,
        child: ClipRect(
          clipBehavior: Clip.hardEdge,
          child: Transform(
            alignment: Alignment.topLeft,
            transform: Matrix4.identity()
              ..translate(context.width/ 2 -
                  barWidth * progression -
                  barWidth / 2),
            child: Container(
              constraints: BoxConstraints(
                minWidth: context.width
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i <= barCount; i++)
                    SizedBox(
                      width: barWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (i % 5 == 0)
                            Text(
                              i.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              softWrap: false,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: (i % 5 == 0) ? 25 : 15,
                            width: (i % 5 == 0) ? 4 : 2,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
