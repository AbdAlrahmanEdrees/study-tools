import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:habits_applicatoin/database.dart';
import 'package:habits_applicatoin/widgets/favorite_hobby_item.dart';

class ShowFavoriteHobbies extends StatefulWidget {
  const ShowFavoriteHobbies({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
  }
}

class MyState extends State {
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
      appBar: AppBar(title: const Text('Fovorite Hobbies')),
      body: ListView.builder(
        itemCount: db.Favorite_Hobbies.length,
        itemBuilder: ((context, index) {
          return FavoriteHobbyItem(
            name: db.Hobbies[db.Favorite_Hobbies[index][0]][0],
            description: db.Hobbies[db.Favorite_Hobbies[index][0]][1],
            benefits: db.Hobbies[db.Favorite_Hobbies[index][0]][2],
            ages: db.Hobbies[db.Favorite_Hobbies[index][0]][3],
            image: db.Hobbies[db.Favorite_Hobbies[index][0]][4],
            level: db.Favorite_Hobbies[index][1],
            start_year: db.Favorite_Hobbies[index][2],
          );
        }),
      ),
    );
  }
}
