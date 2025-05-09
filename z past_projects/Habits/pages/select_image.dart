import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import './add_hobby.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mystate();
  }
}

class mystate extends State<SelectImage> {
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
        //floatingActionButton: FloatingActionButton(onPressed: selectImage),
        body: ListView.builder(
          itemCount: db.Images.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
                onPressed:()=> getImg(db.Images[index]),
                child: Text('${db.Images[index]}'));
          },
        ));
  }

  void selectImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: db.Images.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    onPressed: getImg(db.Images[index]),
                    child: Text('${db.Images[index]}'));
              },
            ),
          ),
        );
      },
    );
  }

  getImg(imag) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AddHobby(Image: imag,);
      },
    ));
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