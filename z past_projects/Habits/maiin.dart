import 'package:flutter/material.dart';
import 'package:habits_applicatoin/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  var box=await Hive.openBox("Hobbies");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  Map<String, WidgetBuilder> routes = {
    '/': (context) => HomePage(),
    '/FCFS': (context) => FCFSPage(),
    '/FCFSwA': (context) => FCFSwAPage(),
    '/SJF': (context) => SJFPage(),
    '/RR': (context) => RRPage(),
  };*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Hobbies Application",
      //initialRoute: '/',
      //routes: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:HomePage()
    );
  }
}
