import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wordup/view/homepage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() {
//   // Initialize FFI
//   sqfliteFfiInit(); //sqflite ffi is same like sqflite, but for windows
//   // Set database factory   //we can keep this code
//   //and it will work on Android with no problems
//   databaseFactory = databaseFactoryFfi;

//   //initialising ml kit:
//  // WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const GetMaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    //theme: ThemeData.dark(),
  ));
}
