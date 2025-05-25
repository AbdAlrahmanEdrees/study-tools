import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:studytools/control/0.dbcontroller.dart';

class PermissionsPageController extends GetxController {
  RxList<AppInfo> apps = <AppInfo>[].obs;
  // RxList<String> selectedApps = <String>[].obs;
  final DbController _dbController = Get.put(DbController());

  final service = FlutterBackgroundService();
  //We need this to talk to the isolate of the background service,
  // to tell it to refresh its 'selected_apps' list to keep it up to date
  // /to keep it synchronized with the main thread.
  @override
  void onInit() {
    super.onInit();
    loadInstalledApps();
    // Update the screen whenever a change accurs to the list of monitored apps
    //(a new app added, or an app removed)
    _dbController.monitoredApps.listen((d) {
      update();
    });
  }

  Future<void> loadInstalledApps() async {
    final fetchedApps = await InstalledApps.getInstalledApps(true, true);
    apps.value = fetchedApps;
    update();
  }

  void toggleAppSelection(String packageName) async {
    if (isSelected(packageName)) {
      await _dbController.deleteMonitoredApp(packageName);
    } else {
      await _dbController.addMonitoredApp(packageName);
    }

    //telling the background service isolate to refresh its db instance
    service.invoke('refresh_selected_apps');
  }

  bool isSelected(String packageName) {
    bool selected = _dbController.monitoredApps
        .any((app) => app["package_name"] == packageName);
    return selected;
  }
}
