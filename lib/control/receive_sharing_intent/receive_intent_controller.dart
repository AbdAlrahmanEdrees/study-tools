import 'dart:async';

import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReceiveSharingIntentController extends GetxController {
  final sharedFiles = <SharedMediaFile>[].obs;
  final sharedText = ''.obs;
  late StreamSubscription _intentSub;
  @override
  void onInit() {
    super.onInit();

    // Listen for shared media files when the app is in the foreground
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
        (List<SharedMediaFile> value) {
      sharedFiles.clear();
      sharedFiles.addAll(value);
      print(sharedFiles.map((f) => f.toMap()));
    }, onError: (err) {
      print("getMediaStream error: $err");
    });

//listen to media sharing coming from outside the app while the app is closed
    ReceiveSharingIntent.instance
        .getInitialMedia()
        .then((List<SharedMediaFile> value) {
      sharedFiles.clear();
      sharedFiles.addAll(value);
      print(sharedFiles.map((f) => f.toMap()));

      //Tell the library that we are done processing the intent.
      ReceiveSharingIntent.instance.reset();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _intentSub.cancel();
    super.onClose();
  }

  void saveFiles() async {
    // sharedFiles.value.map((f)  {
    //   print(f.path);
    // });
    // print("you pressed the button nnnnnn");
    // Directory s = await getApplicationDocumentsDirectory();
    // print(s.path);
    final directory = await getExternalStorageDirectory();
    for (var i in sharedFiles) {
      if (directory != null) {
        // final name = i.path.split('/').last;
        // final newPath = '${directory.path}/$name';
        // final newFile = await File(i.path).copy(newPath);
        // print(newFile.path);
        // if (await directory.exists()) {
        //   final files = directory.listSync();
        //   print(files);
        final file = File(i.path);
        if (await file.exists()) {
          await file.delete();
          print("deleted successfully");
        }
      }
    }
  }

}
