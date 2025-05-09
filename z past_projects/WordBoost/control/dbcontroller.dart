import 'package:get/get.dart';
import 'package:wordup/model/sqldb.dart';

class DbController extends GetxController {
  SqlDb db = SqlDb();
  RxInt level = 1.obs;
  RxList<Map> stories = <Map>[].obs;
  RxList<Map> words = <Map>[].obs;
  RxList<Map> statistics = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectStories(); // to have actual data of variables in  GetxController class
    //we have to assign the variable to the data in the onInit()
    selectWords();
    selecStatistics();
  }

  void changeLevel(int newlevel) {
    level.value = newlevel;
    selectStories();
  }

  Future<void> selectStories() async {
    List<Map> response = await db.select('''SELECT * FROM stories
    WHERE story_level = ${level.value}''');
    stories.value = response;
  }

  Future<void> deleteStory(int id) async {
    await db.delete('''DELETE FROM stories
    WHERE id=$id''');
    selectStories();
  }

  Future<void> addStory(String title, String text) async {
    await db.insert('''INSERT INTO stories (story_level, title, text)
    values(${level.value},"""$title""","""$text""")''');
    Get.back();
    selectStories();
  }

  Future<void> editStory(String title, String text, int id) async {
    await db.update('''UPDATE stories 
    SET title="""$title""",
    text="""$text"""
    WHERE id=$id''');
    Get.back();
    selectStories();
  }

/////////////////////////for StoryPage - translation controller////////////////////////////////
  void addWord(String word, String translation, int storyId) async {
    await selectWords(); //wait until words=selectWords.response :)
    bool alreadyExists = words.any((row) => row['english'] == word);
    if (!alreadyExists) {
      await db.insert('''INSERT INTO words (story_id, no_of_reviews, english, arabic)
    values($storyId, 0, '$word','$translation')''');
      Get.back();
      selectWords();
    }
    // selectStories();
  }

  //////////////////////for QuizPage/words list - controller///////////////////////////////////
  selectWords() async {
    List<Map> response = await db.select('''SELECT * FROM words
    ORDER BY no_of_reviews ASC'''); // words will be sorted from the least reviewd to the most
    words.value = response;
  }

  void deleteWord(String word) async {
    await db.delete('''DELETE FROM words
    WHERE english='$word' ''');
    selectWords();
  }

  //////////////////////for QuizPage/quiz - controller///////////////////////////////////
  editPlusReview(String word) async {
    await db.update('''UPDATE words 
    SET no_of_reviews=no_of_reviews + 1
    WHERE english='$word' ''');
    selectWords();
  }

  selecStatistics() async {
    List<Map> response = await db.select('''SELECT * FROM stats
    WHERE id=0
    '''); 
    statistics.value = response;
  }

  editHighestStreak(int newHiStreak) async {
    await db.update('''UPDATE stats 
    SET highest_streak=$newHiStreak
    WHERE id=0 ''');
    selecStatistics();
  }
}
