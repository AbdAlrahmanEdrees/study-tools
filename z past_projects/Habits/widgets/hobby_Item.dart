import 'package:flutter/material.dart';

class HobbyItem extends StatelessWidget {
  String name;
  String description;
  String benefits;
  String ages;
  String image;
  bool favorite;
  void Function()? onChanged;
  void Function()? onPressed1;
  void Function()? onPressed2;

  HobbyItem(
      {super.key, required this.name,
      required this.description,
      required this.benefits,
      required this.ages,
      required this.image,
      required this.favorite,
      required this.onChanged,
      required this.onPressed1,
      required this.onPressed2});

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
                      Expanded(child: Text('DESCRIPTION: $description',style: TextStyle(
                          color: Colors.red[50],
                          letterSpacing: 2,
                        ),)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('BENEFITS: $benefits',style: TextStyle(
                          color: Colors.red[100],
                          letterSpacing: 2,
                        ))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text('AGE: $ages',style: TextStyle(
                                color: Colors.grey[200],
                                letterSpacing: 2,
                              )),
                      ),
                      IconButton(onPressed: onPressed1, icon: const Icon(Icons.delete)),
                      IconButton(onPressed: onPressed2, icon: const Icon(Icons.edit)),
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
                  radius: 60,
                ),
                Center(
                  child: favorite
                      ? IconButton(
                          onPressed:  onChanged,
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                        )
                      : IconButton(
                          onPressed: onChanged,
                          icon: const Icon(Icons.favorite_border)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
