import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text("About Us")),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/nigan.png'),
                  radius: 50,
                ),
              ),
              Divider(
                height: 70,
                color: Colors.grey[800],
              ),
              const Text(
                'Name',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              Text(
                'Abd Alrahman Edrees',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'University Number',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              Text(
                '2020 10 675',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'abdalrahmanedrees00@gmail.com',
                      style: TextStyle(
                        color: Colors.grey[400],
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
