import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overlay',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, size: 80, color: Colors.white),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "You're using a monitored app!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FlutterOverlayWindow.closeOverlay();
                    // SystemNavigator.pop(); //optional: closes app if you want
                  },
                  child: const Text("Close Overlay"))
            ],
          ),
        ),
      ),
    );
  }
}
