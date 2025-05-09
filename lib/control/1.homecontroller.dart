import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString title = "Review".obs;
  RxInt index = 1.obs;
  final service = FlutterBackgroundService();
  RxBool backGroundServiceOn = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // checkBackgroundServiceState();
    backGroundServiceOn.value = await service.isRunning();
  }

  void checkBackgroundServiceState() async {
    backGroundServiceOn.value = await service.isRunning();
  }

  // Widget Page = const ReviewPage();
  // bool backButtonVisibility = false;
  void bottomNavigation(int indx) {
    if (indx != index.value) {
      index.value = indx;
      switch (indx) {
        case 0:
          // Page =  StatsPage();
          title.value = "Statistics";
          break;
        case 1:
          // Page = const ReviewPage();
          title.value = "Review";
          break;
        case 2:
          // Page = const PomodoroPage();
          title.value = "Pomodoro";
          break;
      }
      // backButtonVisibility = false;
      // update();
    }
  }

  // void goToTranslator() {
  //   Page = Translator();
  //   backButtonVisibility = true;
  //   update();
  // }

  void toggleBackGroundServiceSlider() async {
    backGroundServiceOn.value = !backGroundServiceOn.value;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (backGroundServiceOn.value) {
        service.startService();
      } else {
        service.invoke('stopService');
      }
    });
  }
}
