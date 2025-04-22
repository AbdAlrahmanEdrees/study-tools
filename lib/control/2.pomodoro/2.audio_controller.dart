import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';

class AudioController extends GetxController {
  final AudioPlayer ringPlayer = AudioPlayer();
  final AudioPlayer tickPlayer = AudioPlayer();
  final String _ringSource = 'ring.wav';
  final String _tickSource = 'tick.wav';
  final DbController _dbController = Get.put(DbController());

  @override
  void onInit() {
    super.onInit();
    _init();

    // // this is a good note and functionality
    // // every .obs (observable variable) you can use with it .listen() function
    // // this function will be performed each time the value of this observable variable changes
    // // of course: p0 is the new value of this observable variable
    // _settingsController.ringingVolume.listen((p0) {
    //   ringPlayer.setVolume(p0);
    // });
    // _settingsController.tickingVolume.listen((p0) {
    //   tickPlayer.setVolume(p0);
    // });
  }

  @override
  void onClose() {
    _dispose();
  }

  Future<void> _init() async {
    // await ringPlayer.setVolume(_dbController.pomodoroSettings[0]['ringing_volume']);
    // await ringPlayer.setSource(AssetSource(_ringSource));
    // // await _player.setPlayerMode(PlayerMode.lowLatency);
    // // await _ringPlayer.setReleaseMode(ReleaseMode.loop);
    await ringPlayer
        .setVolume(_dbController.pomodoroSettings[0]['ticking_volume']);
    final bytes1 = await AudioCache.instance.loadAsBytes(_ringSource);
    await ringPlayer.setSource(BytesSource(bytes1));
    // await _player.setPlayerMode(PlayerMode.lowLatency);
    await ringPlayer.setReleaseMode(ReleaseMode.stop);

    await tickPlayer
        .setVolume(_dbController.pomodoroSettings[0]['ticking_volume']);
    final bytes = await AudioCache.instance.loadAsBytes(_tickSource);
    await tickPlayer.setSource(BytesSource(bytes));
    // await _player.setPlayerMode(PlayerMode.lowLatency);
    await tickPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _dispose() async {
    await ringPlayer.release();
    await ringPlayer.dispose();

    await tickPlayer.release();
    await tickPlayer.dispose();
  }

  Future<void> ring() async {
    await ringPlayer.stop();
    await ringPlayer.resume();
    Future.delayed(const Duration(seconds: 3), () {
      ringPlayer.stop();
    });
  }

  Future<void> startTicking() async {
    await tickPlayer.seek(Duration.zero);
    await tickPlayer.resume();
  }

  Future<void> stopTicking() async {
    await tickPlayer.stop();
  }
}
