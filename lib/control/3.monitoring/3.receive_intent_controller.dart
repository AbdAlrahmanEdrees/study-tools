import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReceiveSharingIntentController extends GetxController {
  List<SharedMediaFile> sharedFiles = <SharedMediaFile>[];
  String sharedText = '';
  @override
  void onInit() {
    super.onInit();

    // Set up method channel
    const methodChannel = MethodChannel('receive_share_intent');
    methodChannel.setMethodCallHandler((call) async {
      FlutterOverlayWindow.shareData(2);
      if (call.method == 'onShareReceived') {
        final data = call.arguments as Map<dynamic, dynamic>;
        final type = data['type'] as String?;
        final path = data['path'] as String?;
        final paths = data['paths'] as List<dynamic>?;

        if (type == 'media') {
          if (path != null) {
            // Single file share
            final sharedFile = SharedMediaFile(
              path: path,
              type: _detectMediaType(path),
            );
            sharedFiles.clear();
            sharedFiles.add(sharedFile);
            print(sharedFiles.map((f) => f.toMap()));
          } else if (paths != null) {
            // Multiple files share
            final sharedFilesList = paths
                .map((p) => SharedMediaFile(
                      path: p.toString(),
                      type: path!=null ?_detectMediaType(path) : SharedMediaType.file,
                    ))
                .toList();
            sharedFiles.clear();
            sharedFiles.addAll(sharedFilesList);
            FlutterOverlayWindow.shareData(sharedFiles);
          }
        } else if (type == 'text') {
          sharedText = data['text'] as String? ?? '';
          FlutterOverlayWindow.shareData(sharedText);
        }
        await FlutterOverlayWindow.showOverlay(
            alignment: OverlayAlignment.topCenter,
            overlayTitle: "Overlay",
            overlayContent: "Monitoring App",
            //enableDrag: true,
            flag: OverlayFlag.focusPointer);
        //Overlay Window runs in an isolate (doesn't share memory with other threads),
        // so we talk to it throw messages like this:
        await FlutterOverlayWindow.shareData('reset_animation');
      }
    });
  }

  SharedMediaType _detectMediaType(String path) {
  final lower = path.toLowerCase();

  // URL detection first
  if (lower.startsWith('http://') || lower.startsWith('https://')) {
    return SharedMediaType.url; // URL is typically treated as text (you can also define your own enum for URL if needed)
  }

  // Image
  if (lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png') ||
      lower.endsWith('.gif') ||
      lower.endsWith('.bmp') ||
      lower.endsWith('.webp')) {
    return SharedMediaType.image;
  }

  // Video
  if (lower.endsWith('.mp4') ||
      lower.endsWith('.avi') ||
      lower.endsWith('.mov') ||
      lower.endsWith('.mkv') ||
      lower.endsWith('.webm')) {
    return SharedMediaType.video;
  }

  // Audio
  if (lower.endsWith('.mp3') ||
      lower.endsWith('.wav') ||
      lower.endsWith('.aac') ||
      lower.endsWith('.ogg') ||
      lower.endsWith('.flac')) {
    return SharedMediaType.file;
  }

  // Fallback to file
  return SharedMediaType.file;
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
