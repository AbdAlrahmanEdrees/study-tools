import 'package:flutter/material.dart';

class AddHobbyy extends StatelessWidget {
  List Hobbies;
  void Function()? update;
  AddHobbyy({super.key, required this.Hobbies,required this.update});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Hobby"),
      ),
      body: const Center(
        child: Text('First'),
      ),
    );
  }
}
