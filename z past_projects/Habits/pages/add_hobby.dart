import 'package:flutter/material.dart';
import 'package:habits_applicatoin/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import './select_image.dart';

class AddHobby extends StatefulWidget {
  String Image;
  AddHobby({super.key, required this.Image});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mystate();
  }
}

class mystate extends State<AddHobby> {
  TextEditingController controller0 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  String selected_img = 'cooking';

  var mybox = Hive.box("Hobbies");
  HobbiesDatabase db = HobbiesDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if (mybox.get("hobbies") == null) {
      db.loadIntialHobbies();
    } else {
      db.getHobbies();
    }
    if (mybox.get('images') == null) {
      db.loadIntialImages();
    } else {
      db.getImages();
    }
    if (mybox.get('favorite') == null) {
      db.loadInitialFavorite();
    } else {
      db.getHobbies();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Hobby"),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: addHobby, child: const Icon(Icons.add)),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => selectImage(), child: const Text('Select Image')),
            Row(
              children: [
                const Text(
                  '  Name : ',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                    child: TextField(
                  controller: controller0,
                ))
              ],
            ),
            Row(
              children: [
                const Text(
                  'Description : ',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                    child: TextField(
                  controller: controller1,
                ))
              ],
            ),
            Row(
              children: [
                const Text(
                  'Benefits : ',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                  controller: controller2,
                ))
              ],
            ),
            Row(
              children: [
                const Text(
                  'Age : ',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                    width: 100,
                    child: TextField(
                      controller: controller3,
                    ))
              ],
            ),
            
            const SizedBox(
              height: 40,
            ),
            Image(image: AssetImage('images/${widget.Image}.png'))
          ],
        ));
  }

  void selectImage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const SelectImage();
      },
    ));
    //Navigator.of(context).pop();
    //Navigator.pushNamed(context, '/FCFSwA');
  }

  void addHobby() {
    bool notExist = true;
    for (int i = 0; i < db.Hobbies.length; i++) {
      if (db.Hobbies[i][0] == controller0.text) notExist = false;
    }
    if (notExist) {
      setState(() {
        db.Hobbies.add([
          controller0.text,
          controller1.text,
          controller2.text,
          controller3.text,
          widget.Image,
          false
        ]);
        controller0.clear();
        controller1.clear();
        controller2.clear();
        controller3.clear();
        controller4.clear();
        db.updateHobbies();
      });
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ));
    }
  }
}
/*
            Row(
              children: [
                Text(
                  'Name : ',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                    child: TextField(
                  controller: controller0,
                ))
              ],
            ),
            Row(
              children: [
                Text(
                  'Description : ',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                    child: TextField(
                  controller: controller1,
                ))
              ],
            ),
            Row(
              children: [
                Text(
                  'Benefits : ',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                    child: TextField(
                  controller: controller2,
                ))
              ],
            ),
            Row(
              children: [
                Text(
                  'Age : ',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                    width: 100,
                    child: TextField(
                      controller: controller0,
                    ))
              ],
            ),*/