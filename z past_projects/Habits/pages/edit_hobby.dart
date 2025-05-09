import 'package:flutter/material.dart';
import 'package:habits_applicatoin/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import './select_edit_image.dart';

class EditHobby extends StatefulWidget {
  int i;
  String image;
  EditHobby({super.key, 
    required this.i,
    required this.image,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mystate();
  }
}

class mystate extends State<EditHobby> {
  TextEditingController controller0 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
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
    int inn = widget.i;
    controller0.text = db.Hobbies[inn][0];
    controller1.text = db.Hobbies[inn][1];
    controller2.text = db.Hobbies[inn][2];
    controller3.text = db.Hobbies[inn][3];
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Hobby"),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: editHobby, child: const Icon(Icons.edit)),
        body: Column(
          children: [
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
            ElevatedButton(
                onPressed: () => selectImage(), child: const Text('Select Image')),
            const SizedBox(
              height: 40,
            ),
            Image(image: AssetImage('images/${widget.image}.png'))
          ],
        ));
  }

  void selectImage() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SelectEditImage(
          i: widget.i,
        );
      },
    ));
    //Navigator.of(context).pop();
    //Navigator.pushNamed(context, '/FCFSwA');
  }

  void editHobby() {
    setState(() {
      db.Hobbies[widget.i][0] = controller0.text;
      db.Hobbies[widget.i][1] = controller1.text;
      db.Hobbies[widget.i][2] = controller2.text;
      db.Hobbies[widget.i][3] = controller3.text;
      db.Hobbies[widget.i][4] = widget.image;
    });
    controller0.clear();
    controller1.clear();
    controller2.clear();
    controller3.clear();
    db.updateHobbies();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
    }
}
