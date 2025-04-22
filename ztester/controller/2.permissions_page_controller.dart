import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:tester/controller/0.dbcontroller.dart';

class PermissionsPageController extends GetxController {
  RxList<AppInfo> apps = <AppInfo>[].obs;
  // RxList<String> selectedApps = <String>[].obs;
  final DbController _dbController = Get.put(DbController());
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
    // Future.delayed(Duration(seconds: 2), () {
    //   print(_dbController.monitoredApps);
    //   update();
    // });
  }

  bool isSelected(String packageName) {
    bool selected = _dbController.monitoredApps
        .any((app) => app["package_name"] == packageName);
    return selected;
  }
}
