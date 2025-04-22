//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/permissions/1.permissions_controller.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});
  final bool usagePermissionGranted = false;
  final bool drawnOverOtherAppsPermissionGranted = false;
  @override
  Widget build(BuildContext context) {
    final PermissionsScreenController controller =
        Get.put(PermissionsScreenController());
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Permissinos Required"),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(24),
        child: Obx(
          () => Column(
            children: [
              Text("This app needs the following Permissions!"),
              SizedBox(height: screenHeight / 5),
              SizedBox(
                height: screenHeight / 10,
                width: 300,
                child: _permissionTile(
                    title: "Usage Access",
                    granted: controller.hasUsagePermission.value,
                    onTap: controller.requestUsagePermission),
              ),
              SizedBox(height: screenHeight / 5),
              SizedBox(
                  height: screenHeight / 15,
                  width: 300,
                  child: _permissionTile(
                      title: "Draw over Other Apps (overlay)",
                      granted: controller.hasOverlayPermission.value,
                      onTap: controller.requestOverlayPermission)),
              SizedBox(
                height: screenHeight / 5,
              ),
              if (controller.hasOverlayPermission.value &&
                  controller.hasUsagePermission.value)
                const Text(
                  "All permissions granted! You will be redirected soon...",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                )
            ],
          ),
        ),
      )),
    );
  }

  Widget _permissionTile({
    required String title,
    required bool granted,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(granted ? "Granted" : "Not granted"),
      trailing: Icon(
        granted ? Icons.check_circle : Icons.warning,
        color: granted ? Colors.green : Colors.red,
      ),
      onTap: granted ? null : onTap,
    );
  }
}
