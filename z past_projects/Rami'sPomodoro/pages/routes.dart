import 'package:flutter/material.dart';
import 'package:refreshing/controllers/pomodoro_binding.dart';
import 'package:refreshing/controllers/settings_binding.dart';
import 'package:refreshing/controllers/tasks_binding.dart';
import 'package:refreshing/pages/pomodoro/pomodoro_page.dart';
import 'package:refreshing/pages/settings/settings_page.dart';
import 'package:refreshing/pages/tasks/task_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
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
      ],
      initialRoute: PomodoroPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
