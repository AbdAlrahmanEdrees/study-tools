import 'package:get/get.dart';

import 'tasks_controller.dart';

class TasksBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TasksController());
  }
}
