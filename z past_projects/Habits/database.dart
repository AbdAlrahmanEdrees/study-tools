//import 'package:hive_flutter/hive_flutter.dart';

class HobbiesDatabase {
  List Images = [];
  List Hobbies = [];
  List Favorite_Hobbies = [];
  var mybox = Hive.box("Hobbies");
  void loadIntialHobbies() {
    Hobbies = [
      [
        "football",
        "a family of team sports that involve, to varying degrees, kicking a ball to score a goal.",
        "increased stamina, improved cardiovascular health, reduced body fat,improved muscle strength and tone, increased bone strength, improved coordination",
        "15-40",
        "football",
        true,
      ],
      [
        "chess",
        "a game played between two opponents on opposite sides of a board containing 64 squares of alternating colors",
        "Develops perspective, Improves memory, Deepens focus, Elevates creativity, Boosts planning skills, Increases self-awareness, Protects against dementia, Helps ADHD",
        "7-77",
        "chess",
        false,
      ]
    ];
    //
    
  }
  void loadInitialFavorite(){
    Favorite_Hobbies =[ [0, "professional", "2015"]];
  }
  void loadIntialImages(){
    Images = ['non', 'football', 'chess', 'basketball', 'tennis', 'swimming', 'horseriding', 'cycling', 'badminton', 'cooking', 'reading', 'photography', 'photoshop', 'playmusic', 'singing', 'watchingfilms', 'writing', 'dance'];
  }
///////////////////////////////////////////////////////////////////
  void getHobbies() {
    Hobbies = mybox.get('hobbies');
  }

  void getImages() {
    Images = mybox.get('images');
  }

  void getFavorite() {
    Favorite_Hobbies = mybox.get('favorite');
  }
////////////////////////////////////////////////////////
  void updateHobbies() {
    mybox.put("hobbies", Hobbies);
  }

  void updateFavorite() {
    mybox.put("favorite", Favorite_Hobbies);
  }

/*
  void updateImages() {
    mybox.put("images", Images);
  }*/
}
