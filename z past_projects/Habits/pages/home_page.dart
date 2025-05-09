import 'package:flutter/material.dart';
import 'package:habits_applicatoin/pages/edit_hobby.dart';
import 'package:habits_applicatoin/pages/favorite_hobbies.dart';
import 'package:habits_applicatoin/pages/add_hobby.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import './about_us_page.dart';
import 'package:habits_applicatoin/widgets/hobby_Item.dart';
import 'package:habits_applicatoin/widgets/favorite_hobby_item.dart';
import './show_favorite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
  }
}

class MyState extends State {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
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
      db.getFavorite();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Hobbies List")),
      //floatingActionButton:
      //FloatingActionButton(child: Icon(Icons.add), onPressed: addHabit),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[600]),
              accountName: const Text("Hobbies Application"),
              accountEmail: const Text(""),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/non.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(" Add New Hobby "),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddHobby(
                      Image: 'non',
                    );
                  },
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text(" Favorite Hobbies "),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const ShowFavoriteHobbies();
                  },
                ));
              },
            ),
            const Expanded(child: SizedBox()),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Aboud Us"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AboutUsPage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: db.Hobbies.length,
        itemBuilder: ((context, index) {
          return HobbyItem(
            name: db.Hobbies[index][0],
            description: db.Hobbies[index][1],
            benefits: db.Hobbies[index][2],
            ages: db.Hobbies[index][3],
            image: db.Hobbies[index][4],
            favorite: db.Hobbies[index][5],
            onChanged: () => onChanged(index),
            onPressed1: () => deleteHobby(index),
            onPressed2: () => editHobby(index),
          );
        }),
      ),
    );
  }

  onChanged(int index) {
    print(db.Favorite_Hobbies);
    print(db.Hobbies);
    print("**");
    print(db.Images);
    if (!db.Hobbies[index][5]) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('What is your level at this hobby ?'),
                TextField(
                  controller: controller1,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('When did you start practicing it ?'),
                TextField(
                  controller: controller2,
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => addToFavorite(index),
                        child: const Text('Save')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                  ],
                )
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        db.Hobbies[index][5] = !db.Hobbies[index][5];
        for (int i = 0; i < db.Favorite_Hobbies.length; i++) {
          if (db.Favorite_Hobbies[i][0] == index) {
            db.Favorite_Hobbies.removeAt(i);
          }
        }
        db.updateFavorite();
        db.updateHobbies();
      });
    }
  }

  void addToFavorite(int index) {
    setState(() {
      db.Hobbies[index][5] = !db.Hobbies[index][5];
      db.Favorite_Hobbies.add([index, controller1.text, controller2.text]);
      controller1.clear();
      controller2.clear();
      db.updateHobbies();
      db.updateFavorite();
    });
    Navigator.of(context).pop();
  }

  deleteHobby(int index) {
    setState(() {
      db.Hobbies.removeAt(index);
      for (int i = 0; i < db.Favorite_Hobbies.length; i++) {
        if (db.Favorite_Hobbies[i][0] == index) {
          db.Favorite_Hobbies.removeAt(i);
          db.updateFavorite();
        }
      }
      db.updateHobbies();
    });
  }

  editHobby(int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EditHobby(image: '${db.Hobbies[index][4]}', i: index);
      },
    ));
  }

/*  void saveHobby() {
    setState(() {
      db.updateHobbies();
    });
    Navigator.of(context).pop();
  }*/

/*     IMAGE
  edit(int index) {
    controller.text = db.Images[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
              height: 200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            saveEdit(index);
                          },
                          child: Text("Edit"),
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Cancel"),
                        )
                      ],
                    )
                  ])),
        );
      },
    );
  }   
  void saveEdit(int index) {
    setState(() {
      db.Images[index] = controller.text;
      controller.clear();
      db.updateImages();
    });
    Navigator.of(context).pop();
  }*/
}







/*
Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 109, 109, 108),
              ),
              child: Stack(
            children: [
              CircleAvatar(
            backgroundImage:
                AssetImage('images/${db.Hobbies[index][4]}.png'),
            radius: 50,
              ),
              Center(
            child: db.Hobbies[index][5]
                  ? IconButton(onPressed:()=>onChanged(index),icon: Icon(Icons.favorite), color: Colors.red,)
                  : IconButton(onPressed: ()=>onChanged(index), icon: Icon(Icons.favorite_border)),
              ),
            ],
          )
            );
            */

            /*
  void addHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade400,
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: controller,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: savetask,
                        child: Text("Save"),
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancle"),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void savetask() {
    setState(() {
      db.Images.add(controller.text);
      controller.clear();
    });
    Navigator.of(context).pop();
  }*/