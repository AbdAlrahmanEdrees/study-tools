import 'package:get/get.dart';
import 'package:studytools/model/sqldb.dart';
  import 'dart:io';

class DbController extends GetxController {
  SqlDb db = SqlDb();
  RxString language = "english".obs;
  //the default ""-null value of name_of_working_on_task, means that there is no
  //determined task that the user is working on now
  RxString name_of_working_on_task = "".obs;
  RxString done_to_need_to_be_done = "".obs;
  int id_of_working_on_task = 0;
  int pomodoro_stages_of_working_on_task = 0;
  int done_pomodoro_stages_of_working_on_task = 0;
  RxInt level = 1.obs;
  RxList<Map> pomodoroSettings = <Map>[].obs;
  RxList<Map> stories = <Map>[].obs;
  RxList<Map> words = <Map>[].obs;
  RxList<Map> tasks = <Map>[].obs;
  RxList<Map> statistics = <Map>[].obs;
  RxList<Map> monitoredApps = <Map>[].obs;
  RxInt barCount = 25.obs;
  late RxString clockType = 'minutes'.obs;
  //we will only use it to reset the pomodoro timer whenever any of the values
  //(p_duration, short_break, long_break) is edited
  // final PomodoroController _pomodoroController = Get.put(PomodoroController());
  // we will only use it to set the ringing and ticking volumes
  //for ringPlayer and tickPlayer
  // final AudioController _audioController = Get.put(AudioController());
  @override
  void onInit() {
    super.onInit();
    // to have actual data of variables in  GetxController class
    //we have to assign the variable to the data in the onInit()
    selectPomodoroSettings();
    selectStories();
    selectWords();
    selectTasks();
    selectStatistics();
    selectMonitoredApps();
  }

  void changeLanguage(String newLanguage) {
    language.value = newLanguage;
    selectStories();
    selectWords();
  }

  void _changeBarCount() {
    barCount.value = (pomodoroSettings[0]['pomodoro_duration'] >
            pomodoroSettings[0]['long_break_duration'])
        ? pomodoroSettings[0]['pomodoro_duration']
        : pomodoroSettings[0]['long_break_duration'];
  }

////////////////////////////    Stories        ///////////////////////////////////
  Future<void> selectStories() async {
    List<Map> response = await db.select('''SELECT * FROM stories
    WHERE story_language = '${language.value}'
    ORDER BY story_level ASC''');
    stories.value = response;
  }

  Future<void> deleteStory(int id) async {
    await db.delete('''DELETE FROM stories
    WHERE id=$id''');
    selectStories();
    await db.update('''UPDATE statistics
    SET no_of_curr_stories=no_of_curr_stories - 1
    WHERE id=0''');
    selectStatistics();
  }

  Future<void> addStory(String title, String text) async {
    await db.insert(
        '''INSERT INTO stories (story_language, story_level, title, text)
    values('${language.value}',${level.value},'$title','$text')''');
    Get.back();
    selectStories();
    await db.update('''UPDATE statistics
    SET no_of_stories_added=no_of_stories_added + 1,
        no_of_curr_stories=no_of_curr_stories + 1
    WHERE id=0''');
    selectStatistics();
  }

  Future<void> editStory(String title, String text, int id) async {
    await db.update('''UPDATE stories 
    SET story_level=${level.value},
        title='$title',
        text='$text'
    WHERE id=$id''');
    Get.back();
    selectStories();
  }

////////////////////////////     Words         ///////////////////////////////////
  Future<void> selectWords() async {
    List<Map> response = await db.select('''SELECT * FROM words
    WHERE language = '${language.value}'
    ORDER BY no_of_reviews ASC'''); // words will be sorted from the least reviewd to the most
    words.value = response;
  }

  Future<void> addWord(String word, String translation, int storyId) async {
    // print("trying....");
    await selectWords(); //wait until words=selectWords.response :)
    bool alreadyExists = words.any((row) => row['word'] == word);
    if (!alreadyExists) {
      await db.insert(
          '''INSERT INTO words (id,language, no_of_reviews, word, translation)
    values($storyId,'${language.value}', 0, '$word','$translation')''');
      Get.back();
      selectWords();
      await db.update('''UPDATE statistics
    SET no_of_words_added=no_of_words_added + 1,
        no_of_curr_words=no_of_curr_words + 1
    WHERE id=0''');
      selectStatistics();
    }
    // selectStories();
  }

  Future<void> deleteWord(String word) async {
    await db.delete('''DELETE FROM words
    WHERE word='$word' ''');
    selectWords();
    await db.update('''UPDATE statistics
    SET no_of_curr_words=no_of_curr_words - 1
    WHERE id=0''');
    selectStatistics();
  }

  ////////////////////////////    Tasks        ///////////////////////////////////
  Future<void> selectTasks() async {
    List<Map> response = await db.select('''SELECT * FROM tasks''');
    tasks.value = response;
    _selectWorkingOnTaskAttributes();
  }

  Future<void> _achieveTask() async {
    int response = await db.update('''UPDATE tasks 
    SET state=1
    WHERE done_pomodoro_stages=pomodoro_stages''');
    if (response > 0) {
      selectTasks();
      await db.update('''UPDATE statistics
    SET no_of_tasks_achieved=no_of_tasks_achieved + 1,
        no_of_curr_not_achieved_tasks=no_of_curr_not_achieved_tasks-1
    WHERE id=0''');
      selectStatistics();
    }
  }

  Future<void> achievePomodoroStageOfTask() async {
    await db.update('''UPDATE tasks 
    SET done_pomodoro_stages=done_pomodoro_stages + 1
    WHERE task_name= '${name_of_working_on_task.value}\'''');
    selectTasks();
    _achieveTask();
    //this function:
    //
    achievePomodoroStage();
  }

  Future<void> _selectWorkingOnTaskAttributes() async {
    List<Map> response = await db.select('''SELECT * FROM tasks
    WHERE working_on_task_indicator = 1''');
    if (response.isNotEmpty) {
      id_of_working_on_task = response[0]['id'];
      name_of_working_on_task.value = response[0]['task_name'];
      pomodoro_stages_of_working_on_task = response[0]['pomodoro_stages'];
      done_pomodoro_stages_of_working_on_task =
          response[0]['done_pomodoro_stages'];
      done_to_need_to_be_done.value =
          "$done_pomodoro_stages_of_working_on_task/$pomodoro_stages_of_working_on_task";
    } else {
      //the default "" value of name_of_working_on_task, means that there is no
      //determined task that the user is working on now
      name_of_working_on_task.value = "";
    }
  }

  Future<void> setWorkingOnTask(int id) async {
    //at most, there is one task with 'working_on_task_indicator' = 1
    // and the rest of tasks, their 'working_on_task_indicator'=0
    if (name_of_working_on_task.value != "") {
      await db.update('''UPDATE tasks
    SET working_on_task_indicator = 0
    WHERE id=$id_of_working_on_task''');
    }
    await db.update('''UPDATE tasks
    SET working_on_task_indicator = 1
    WHERE id=$id''');
    _selectWorkingOnTaskAttributes();
    Get.back();
  }

  Future<void> deleteTask(int id) async {
    await db.delete('''DELETE FROM tasks
    WHERE id=$id''');
    selectTasks();
    await db.update('''UPDATE statistics
    SET no_of_curr_not_achieved_tasks=no_of_curr_not_achieved_tasks - 1
    WHERE id=0''');
    selectStatistics();
  }

  Future<void> addTask(String name, int pomodoroStages) async {
    await db.insert(
        '''INSERT INTO tasks (task_name, pomodoro_stages,done_pomodoro_stages,task_state,working_on_task_indicator)
    values('$name',$pomodoroStages,0,0,0)''');
    selectTasks();
    Get.back();
    await db.update('''UPDATE statistics
    SET no_of_curr_not_achieved_tasks=no_of_curr_not_achieved_tasks + 1
    WHERE id=0''');
    selectStatistics();
  }

  Future<void> editTask(String name, int pomodoroStages, int id) async {
    await db.update('''UPDATE tasks 
    SET task_name='$name',
        pomodoro_stages=$pomodoroStages
    WHERE id=$id''');
    selectTasks();
    Get.back();
  }

//////////////////////////// Pomodoro Settings ///////////////////////////////////
  Future<void> selectPomodoroSettings() async {
    List<Map> response = await db.select('''SELECT * FROM pomodoro_settings
    WHERE id=0
    ''');
    pomodoroSettings.value = response;
    clockType.value = pomodoroSettings[0]['type_of_clock'];
    _changeBarCount();
  }

  Future<void> updateRingingVolume(double volume) async {
    await db.update('''UPDATE pomodoro_settings 
    SET ringing_volume=$volume
    WHERE id=0''');
    selectPomodoroSettings();
  }

  Future<void> updateTickingVolume(double volume) async {
    await db.update('''UPDATE pomodoro_settings 
    SET ticking_volume=$volume
    WHERE id=0''');
    selectPomodoroSettings();
  }

  Future<void> updateShortBreakDuration(int? minutes) async {
    if (minutes != null) {
      await db.update('''UPDATE pomodoro_settings 
    SET short_break_duration=$minutes
    WHERE id=0''');
      selectPomodoroSettings();
    }
  }

  Future<void> updateLongBreakDuration(int? minutes) async {
    if (minutes != null) {
      await db.update('''UPDATE pomodoro_settings 
    SET long_break_duration=$minutes
    WHERE id=0''');
      selectPomodoroSettings();
    }
  }

  Future<void> updatePomodoroDuration(int? minutes) async {
    if (minutes != null) {
      await db.update('''UPDATE pomodoro_settings 
    SET pomodoro_duration=$minutes
    WHERE id=0''');
      selectPomodoroSettings();
    }
  }

  Future<void> updateClockType(String type) async {
    await db.update('''UPDATE pomodoro_settings 
    SET type_of_clock='$type'
    WHERE id=0''');
    clockType.value = type;
    selectPomodoroSettings();
  }

////////////////////////////    Statistics     ///////////////////////////////////

  Future<void> selectStatistics() async {
    List<Map> response = await db.select('''SELECT * FROM statistics
    WHERE id=0
    ''');
    statistics.value = response;
  }

  Future<void> achievePomodoroStage() async {
    await db.update('''UPDATE statistics
    SET no_of_achieved_pomodoro_stages=no_of_achieved_pomodoro_stages + 1
    WHERE id=0 ''');
    selectStatistics();
  }

  Future<void> wordPlusReview(String word) async {
    await db.update('''UPDATE words 
    SET no_of_reviews=no_of_reviews + 1
    WHERE word='$word' ''');
    // selectWords();
    //It is maybe because of this selectWords(), the bug of quiz was happening
  }

  Future<void> editHighestStreak(int newHiStreak) async {
    await db.update('''UPDATE statistics
    SET highest_correct_answers_streak=$newHiStreak
    WHERE id=0 ''');
    selectStatistics();
  }

  Future<void> numberOfQuizzesPlusOne() async {
    await db.update('''UPDATE statistics
    SET no_of_quizzes_taken=no_of_quizzes_taken + 1
    WHERE id=0 ''');
    selectStatistics();
  }

  ////////////////////////////// Monitored Apps ///////////////////////////////////////////

  Future<void> selectMonitoredApps() async {
    List<Map> response = await db.select('''SELECT * FROM monitored_apps''');
    monitoredApps.value = response;
  }
  Future<void> deleteMonitoredApp(String packageName) async {
    await db.delete('''DELETE FROM monitored_apps
    WHERE package_name='$packageName'
    ''');
    selectMonitoredApps();
  }

  Future<void> addMonitoredApp(String packageName) async {
    await db.insert(
        '''INSERT INTO monitored_apps (package_name)
    values('$packageName')''');
    selectMonitoredApps();
  }


  ///////////////////////////// Files DB ////////////////////////////////

Future<void> deleteFile(String filePath) async {
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
    print('File deleted successfully.');
  } else {
    print('File does not exist.');
  }


//   try {
//   final file = File(filePath);
//   if (await file.exists()) {
//     await file.delete();
//     print('File deleted.');
//   } else {
//     print('No file found.');
//   }
// } catch (e) {
//   print('Error deleting file: $e');
// }
// ALSO ask the user if he really wants to
}

}
