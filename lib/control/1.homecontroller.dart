import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  RxString title = "Review".obs;
  RxInt index = 1.obs;
  final service = FlutterBackgroundService();
  RxBool backGroundServiceOn = false.obs;
  RxBool isSignedIn = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn.value = false;
        print(
            '===============================================User is currently signed out!');
      } else {
        isSignedIn.value = true;
        print(
            '===============================================User is signed in!');
      }
    });
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

  //////////////////////////// Sign In With Google   google_sign_in package ///////////////////////////
Future<void> signInWithGoogle() async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      print("⚠️ User canceled the sign-in.");
      return;
    }

    final googleAuth = await googleUser.authentication;
    print("🔐 idToken: ${googleAuth.idToken}");
    print("🔑 accessToken: ${googleAuth.accessToken}");

    if (googleAuth.idToken == null || googleAuth.accessToken == null) {
      print("❌ Tokens are null");
      return;
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    print("✅ Firebase user: ${result.user?.email}");
  } catch (e) {
    print("🔥 Firebase sign-in failed: $e");
  }
}


  void signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
      print("*_*_*_*_*_*_*_*_${user.email}");
    else {
      print("*_*_*_*_ there was no user");
    }
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
