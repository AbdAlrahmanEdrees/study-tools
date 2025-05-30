import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/4.drawer/1.select_apps_page_controller.dart';
import 'package:studytools/model/appcolors.dart';

class SelectAppsToMonitor extends StatelessWidget {
  const SelectAppsToMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionsPageController>(
      init: PermissionsPageController(),
      builder: (controller) {
        if (controller.apps.isEmpty) {
          return const Scaffold(
            backgroundColor: AppColors.red4,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.red3,
          appBar: AppBar(
            backgroundColor: AppColors.red1,
            title: const Text('Select Apps to Monitor'),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: controller.apps.length,
            itemBuilder: (context, index) {
              final app = controller.apps[index];
              final isSelected = controller.isSelected(app.packageName);

              return ListTile(
                leading: app.icon != null
                    ? Image.memory(app.icon!, width: 40, height: 40)
                    : const Icon(Icons.android),
                title: Text(app.name),
                subtitle: Text(app.packageName),
                trailing: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                onTap: () => controller.toggleAppSelection(app.packageName),
              );
            },
          ),
        );
      },
    );
  }
}
