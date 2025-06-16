import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studytools/model/appcolors.dart';
import 'package:studytools/view/5.login_page/1.login_page.dart';

class RegisterationPage extends StatelessWidget {
  const RegisterationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: GoogleFonts.poppins(
              color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.red1,
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.red3,
                AppColors.red3,
                Colors.red.shade600,
                Colors.red.shade500,
                Colors.red.shade500,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade400,
                Colors.red.shade500,
                Colors.red.shade500,
                Colors.red.shade600,
                AppColors.red3,
                AppColors.red3,
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: ListView(children: [
            SizedBox(
              height: screenHeight / 6,
              child: Image.asset(
                'assets/images/app_logo.png',
                scale: 0.1,
              ),
            ),
            Text(
              "User Name",
              style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            TextFormField(
              style: GoogleFonts.poppins(
                  color: Colors.black87, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  hintText: "Input Your User Name",
                  filled: true,
                  fillColor: AppColors.yellow,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black))),
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            Text(
              "Email",
              style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            TextFormField(
              style: GoogleFonts.poppins(
                  color: Colors.black87, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  hintText: "Input Your Email",
                  filled: true,
                  fillColor: AppColors.yellow,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black))),
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            Text(
              "Password",
              style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            TextFormField(
              style: GoogleFonts.poppins(
                  color: Colors.black87, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  hintText: "Set Your Password for StudyTools",
                  filled: true,
                  fillColor: AppColors.yellow,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black))),
            ),
            // Container(
            //   alignment: Alignment.topRight,
            //   margin: EdgeInsets.only(top: 10, bottom: 20),
            //   child: Text(
            //     "Forgot Password?",
            //     style: GoogleFonts.poppins(
            //         color: Colors.black87,
            //         fontWeight: FontWeight.w500,
            //         fontSize: 14),
            //   ),
            // ),
            SizedBox(
              height: screenHeight / 25,
            ),
            MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              color: Colors.orange,
              textColor: Colors.black,
              child: Text("Sign Up",
                  style: GoogleFonts.poppins(
                      color: Colors.black87, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: screenHeight / 45,
            ),
            // Text("or",
            //     textAlign: TextAlign.center,
            //     style: GoogleFonts.poppins(
            //         color: Colors.black87, fontWeight: FontWeight.w600)),
            // SizedBox(
            //   height: screenHeight / 45,
            // ),
            // MaterialButton(
            //   onPressed: () {},
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   height: 40,
            //   color: AppColors.red3,
            //   textColor: Colors.black,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("Login with Google",
            //           style: GoogleFonts.poppins(
            //               color: Colors.black87, fontWeight: FontWeight.w600)),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Image.asset(
            //         'assets/images/google.png',
            //         width: 30,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: screenHeight / 25,
            ),
            InkWell(
              onTap: () {
                Get.back();
                Get.to(LoginPage());
                // Get.replace(LoginPage());
              },
              child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "have an account?"),
                    TextSpan(
                        text: " Login",
                        style: TextStyle(color: AppColors.yellow))
                  ]),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.black87, fontWeight: FontWeight.w500)),
            ),
          ])),
    );
  }
}
