import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import './edit_hobby.dart';

class SelectEditImage extends StatefulWidget {
  int i;
  SelectEditImage({super.key, required this.i});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mystate();
  }
}

class mystate extends State<SelectEditImage> {
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
                onPressed: () => getImg(db.Images[index]),
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
        return EditHobby(image: imag, i: widget.i);
      },
    ));
  }
}
