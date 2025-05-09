// import 'package:flutter/material.dart';
// import 'package:wordup/model/appcolors.dart';


// class QuizWidget extends StatelessWidget {
//   const QuizWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 30, 8, 30),
//                       child: MaterialButton(
//                           color: AppColors.secondColor,
//                           onPressed: () {},
//                           child: Text(
//                               ' ${controller.dbWords[index]['english']} ')),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     // Replace with your item builder logic for the second ListView
//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 30, 8, 30),
//                       child: MaterialButton(
//                           color: AppColors.secondColor,
//                           onPressed: () {},
//                           child:
//                               Text(' ${controller.dbWords[index]['arabic']} ')),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//   }
// }