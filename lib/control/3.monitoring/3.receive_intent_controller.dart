import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class ReceiveSharingIntentController extends GetxController {
  List<Map<String, String>> sharedFiles = [{}];
  Map sharedText = {};
  @override
  void onInit() async {
    super.onInit();
    // Set up method channel
    const methodChannel = MethodChannel('receive_share_intent');
    methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'onShareReceived') {
        final data = call.arguments as Map<dynamic, dynamic>;
        final type = data['type'] as String?;
        final path = data['path'] as String?;
        final paths = data['paths'] as List<dynamic>?;

        if (type == 'media') {
          sharedText.clear();
          sharedFiles.clear();
          if (path != null) {
            // Single file share
            final sharedFile = {
              'path': path,
              'type': _detectMediaType(path),
            };
            sharedFiles.add(sharedFile);
            //Overlay Window runs in an isolate (doesn't share memory with other threads),
            // so we talk to it throw messages like this:
            FlutterOverlayWindow.shareData(sharedFiles);
          } else if (paths != null) {
            // Multiple files share
            final sharedFilesList = paths
                .map((p) => {
                      'path': p != null ? p.toString() : '',
                      'type': p != null ? _detectMediaType(p.toString()) : '',
                    })
                .toList();
            sharedFiles = sharedFilesList;
            // dart isolates can only share messages of raw (native) data
            // Lists like <ShareMediaFile>[] can not be shared, sharing it will crash the program!
            FlutterOverlayWindow.shareData(sharedFiles);
          }
        } else if (type == 'text') {
          sharedFiles.clear();
          sharedText = {
            'path': data['text'] as String,
            'type': _detectText(data['text'] as String)
          };
          FlutterOverlayWindow.shareData(sharedText);
        }
        await FlutterOverlayWindow.showOverlay(
            alignment: OverlayAlignment.topCenter,
            overlayTitle: "Overlay",
            overlayContent: "Monitoring App",
            // height: 400,
            // width: 400,
            //enableDrag: true,
            flag: OverlayFlag.focusPointer);
      }
    });
  }

  String _detectMediaType(String path) {
    final lower = path.toLowerCase();

    // Image
    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.bmp') ||
        lower.endsWith('.webp')) {
      return 'image';
    }

    // Video
    if (lower.endsWith('.mp4') ||
        lower.endsWith('.avi') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.mkv') ||
        lower.endsWith('.webm')) {
      return 'video';
    }

    // Audio
    if (lower.endsWith('.mp3') ||
        lower.endsWith('.wav') ||
        lower.endsWith('.aac') ||
        lower.endsWith('.ogg') ||
        lower.endsWith('.flac')) {
      return 'audio';
    }

    // Fallback to not-included
    return 'not-included';
  }

  _detectText(String text) {
    final lower = text.toLowerCase();

    // URL detection first
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return 'url'; // URL is typically treated as text (you can also define your own enum for URL if needed)
    } else {
      return 'text';
    }
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   _intentSub.cancel();
  //   super.onClose();
  // }

  // void saveFiles() async {
  //   // sharedFiles.value.map((f)  {
  //   //   print(f.path);
  //   // });
  //   // print("you pressed the button nnnnnn");
  //   // Directory s = await getApplicationDocumentsDirectory();
  //   // print(s.path);
  //   final directory = await getExternalStorageDirectory();
  //   for (var i in sharedFiles) {
  //     if (directory != null) {
  //       // final name = i.path.split('/').last;
  //       // final newPath = '${directory.path}/$name';
  //       // final newFile = await File(i.path).copy(newPath);
  //       // print(newFile.path);
  //       // if (await directory.exists()) {
  //       //   final files = directory.listSync();
  //       //   print(files);
  //       final file = File(i.path);
  //       if (await file.exists()) {
  //         await file.delete();
  //         print("deleted successfully");
  //       }
  //     }
  //   }
  // }
}
