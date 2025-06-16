import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/2.snapscontroller.dart';
import 'package:studytools/model/appcolors.dart';

class ReviewTodaySnapsList extends StatelessWidget {
  const ReviewTodaySnapsList({super.key});
  // final DbController _dbController = Get.find<DbController>();
  @override
  Widget build(BuildContext context) {
    Get.put(SnapsController());
    return GetBuilder<SnapsController>(builder: (controller) {
      if (controller.noSnapsToReviewToday.value) {
        return Scaffold(
          backgroundColor: AppColors.red1,
          appBar: AppBar(
            backgroundColor: AppColors.red2,
            title: Text("No Snaps To Review Today"),
            centerTitle: true,
          ),body: Center(child: Text("There are no snaps to review on this date"),),
        );
      } else if (controller.userShouldWait.value) {
        return Scaffold(
          backgroundColor: AppColors.red1,
          appBar: AppBar(
            backgroundColor: AppColors.red2,
            title: Text("Today's Snaps List"),
            centerTitle: true,
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Scaffold(
            backgroundColor: AppColors.red1,
            appBar: AppBar(
              backgroundColor: AppColors.red2,
              title: Text("Today's Snaps List"),
              centerTitle: true,
            ),
            body: Container(
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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: controller.todaySnaps.length,
                itemBuilder: (context, index) {
                  final snap = controller.todaySnaps[index];
                  if (snap['type'] == 'text') {
                    // return controller.textSnapWidget(index, context);
                    return textSnapWidget(snap['snap']);
                  } else if (snap['type'] == 'url') {
                    return urlSnapWidget(snap['snap']);
                  } else {
                    return imageAndVideoSnapWidget(snap['snap']);
                  }
                },
              ),
            ));
      }
    });
  }
}

Widget imageAndVideoSnapWidget(String path) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.perm_media_rounded),
      title: Text(path),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}

Widget urlSnapWidget(String path) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.link),
      title: Text(path),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}

Widget textSnapWidget(String path) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.note),
      title: Text(path),
    ),
    const SizedBox(
      height: 20,
    )
  ]);
}
