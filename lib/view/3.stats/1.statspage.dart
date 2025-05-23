import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/model/appcolors.dart';

class StatsPage extends StatelessWidget {
  StatsPage({super.key});

  final DbController controller = Get.put(DbController());

  Widget buildStatRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.red.shade800,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.red4,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stats = controller.statistics[0];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade900,
              Colors.red.shade700,
              Colors.red.shade700,
              Colors.red.shade500,
              Colors.red.shade400,
              Colors.red.shade400,
              Colors.red.shade500,
              Colors.red.shade700,
              Colors.red.shade700,
              Colors.red.shade900,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: context.height / 30),

            // --- Current Stats ---
            SizedBox(
              width: context.width * 0.95,
              child: Card(
                color: Colors.white60,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      const Text(
                        "Current",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      buildStatRow(context, 'Number of Tasks Not Achieved',
                          stats['no_of_curr_not_achieved_tasks'].toString(), Icons.cancel),
                      buildStatRow(context, 'Number of Stories',
                          stats['no_of_curr_stories'].toString(), Icons.book),
                      buildStatRow(context, 'Number of Words',
                          stats['no_of_curr_words'].toString(), Icons.text_fields),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: context.height / 70),

            // --- Highest Streak ---
            SizedBox(
              width: context.width * 0.95,
              child: Card(
                color: Colors.white60,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: buildStatRow(
                  context,
                  'Highest Correct-Answers Streak',
                  stats['highest_correct_answers_streak'].toString(),
                  Icons.emoji_events,
                ),
              ),
            ),

            SizedBox(height: context.height / 70),

            // --- Total Stats ---
            SizedBox(
              width: context.width * 0.95,
              child: Card(
                color: Colors.white60,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      buildStatRow(context, 'Number of Quizzes Taken',
                          stats['no_of_quizzes_taken'].toString(), Icons.quiz),
                      buildStatRow(context, 'Number of Achieved Tasks',
                          stats['no_of_achieved_tasks'].toString(), Icons.check_circle),
                      buildStatRow(context, 'Number of Stories Added',
                          stats['no_of_stories_added'].toString(), Icons.library_books),
                      buildStatRow(context, 'Number of Words Added',
                          stats['no_of_words_added'].toString(), Icons.add),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: context.height / 70),

            // --- Pomodoro Stats ---
            SizedBox(
              width: context.width * 0.95,
              child: Card(
                color: Colors.white60,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: buildStatRow(
                  context,
                  'Total Achieved Pomodoro Stages',
                  stats['no_of_achieved_pomodoro_stages'].toString(),
                  Icons.timer,
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
