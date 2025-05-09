import 'package:refreshing/controllers/tasks_binding.dart';
import 'package:refreshing/controllers/tasks_controller.dart';
import 'package:refreshing/pages/Testpage.dart';
import 'package:refreshing/pages/statistics_page.dart';
import 'package:refreshing/pages/tasks/task_page.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'controllers/settings_binding.dart';
import 'controllers/pomodoro_binding.dart';
import 'pages/settings/settings_page.dart';
import 'pages/pomodoro/pomodoro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TasksController(), permanent: true);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pomodoro',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
      getPages: [
        GetPage(
          name: PomodoroPage.routeName,
          page: () => PomodoroPage(),
          bindings: [
            PomodoroBinding(),
            SettingsBinding(),
          ],
        ),
        GetPage(
          name: SettingsPage.routeName,
          page: () => const SettingsPage(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: TaskPage.routeName,
          page: () => TaskPage(),
          binding: TasksBinding(),
        ),
        GetPage(name: StatisticsPage.routeName, page: () => StatisticsPage()),
       GetPage(name: TestsPage.routeName, page: () => TestsPage()),
     
        ],
      initialRoute: PomodoroPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
