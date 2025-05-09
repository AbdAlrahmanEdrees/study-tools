import 'package:flutter/material.dart';

class FavoriteHobbyItem extends StatelessWidget {
  String name;
  String description;
  String benefits;
  String ages;
  String image;
  String level;
  String start_year;

  FavoriteHobbyItem({super.key, 
    required this.name,
    required this.description,
    required this.benefits,
    required this.ages,
    required this.image,
    required this.level,
    required this.start_year
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 109, 109, 108),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'DESCRIPTION: $description',
                        style: TextStyle(
                          color: Colors.red[50],
                          letterSpacing: 2,
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('BENEFITS: $benefits',
                              style: TextStyle(
                                color: Colors.red[100],
                                letterSpacing: 2,
                              ))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text('AGE: $ages',
                            style: TextStyle(
                              color: Colors.grey[200],
                              letterSpacing: 2,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Level : $level',
                              style: TextStyle(
                                color: Colors.red[600],
                                letterSpacing: 2,
                              ))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Started Practicing : $start_year',
                              style: TextStyle(
                                color: Colors.red[600],
                                letterSpacing: 2,
                              ))),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/$image.png'),
                  radius: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
