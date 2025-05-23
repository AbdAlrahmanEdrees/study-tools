import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db; //we need it to not run initialDb() in every query
  Future<Database?> get db async {
    //*Future* bcs it is asyncronous and need to wait
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  deleteDb() async {
    //OR : Future<void> deleteDb() async {
    String databasepath =
        await getDatabasesPath(); //path of the db on ur device
    String path = join(databasepath, 'studytools.db'); //naming our db
    await deleteDatabase(path);

    print("======DB has been deleted=======");
  }

  initialDb() async {
    String databasepath =
        await getDatabasesPath(); //path of the db on ur device
    String path = join(databasepath, 'studytools.db'); //naming our db
    Database studytoolsdb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    //creating our db
    //version==1 means: just created, still never updated
    //when version==1: onCreate will be called (it get called only once)
    //each time the value of 'version' differs, onUpgrade is called
    return studytoolsdb;
  }

  _onCreate(Database db, int version) async {
    // creates db's tabels
    //this function runs only for one time
    //after that if you need to edit db architecture you will use onUpgrade
    //*this function can create only one table:
    await db.execute('''
      CREATE TABLE stories (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      story_language TEXT NOT NULL,
      story_level INTEGER NOT NULL,
      title TEXT NOT NULL,
      text TEXT NOT NULL
    )
  ''');
    await db.execute('''
      CREATE TABLE words (
      id INTEGER NOT NULL REFERENCES stories (id),
      language TEXT NOT NULL,
      no_of_reviews INTEGER NOT NULL,
      word TEXT NOT NULL,
      translation TEXT NOT NULL
    )
  ''');
    await db.execute('''
      CREATE TABLE tasks (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      task_name TEXT NOT NULL,
      pomodoro_stages INTEGER NOT NULL,
      done_pomodoro_stages INTEGER DEFAULT 0,
      task_state INTEGER NOT NULL DEFAULT 0,
      working_on_task_indicator INTEGER DEFAULT 0
    )
  ''');
    await db.execute('''
      CREATE TABLE statistics (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      no_of_curr_not_achieved_tasks INTEGER,
      no_of_curr_stories INTEGER,
      no_of_curr_words INTEGER,
      highest_correct_answers_streak INTEGER,
      no_of_quizzes_taken INTEGER,
      no_of_achieved_tasks INTEGER,
      no_of_stories_added INTEGER,
      no_of_words_added INTEGER,
      no_of_achieved_pomodoro_stages INTEGER
    )
  ''');
    await db.execute('''
      CREATE TABLE pomodoro_settings(
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      ringing_volume DOUBLE,
      ticking_volume DOUBLE,
      pomodoro_duration INTEGER,
      short_break_duration INTEGER,
      long_break_duration INTEGER,
      type_of_clock TEXT)''');
      
    await db.execute('''
      CREATE TABLE monitored_apps(
      package_name TEXT)''');

      
    await db.execute('''
      CREATE TABLE snaps(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      no_of_reviews INTEGER NOT NULL,
      last_review_date DATE NOT NULL,
      next_review_date DATE NOT NULL,
      snap TEXT NOT NULL)''');

    ///// add default rows:

    await db.execute('''
    INSERT INTO pomodoro_settings
    values (0,1.0,0.8,25,5,20,'minutes')
 ''');
    await db.execute('''
    INSERT INTO statistics
    values (0,0,2,0,0,0,0,2,0,0)
 ''');

    await db.execute('''
    INSERT INTO stories (story_language, story_level, title, text)
    values('english',1,'First English Story','Hi, double click on any word to see its translation and add it to your db')
 ''');

    await db.execute('''
    INSERT INTO stories (story_language, story_level, title, text)
    values('german',1,'Easy level german conversation','Anna: Hallo, Lukas! Wie geht es dir?

Lukas: Hallo, Anna! Mir geht es gut, danke. Und dir?

Anna: Mir geht es auch gut. Was machst du hier?

Lukas: Ich war in der Nähe und wollte einen Kaffee trinken. Und du?

Anna: Ich wollte auch einen Kaffee trinken. Welchen Kaffee bestellst du?

Lukas: Ich bestelle einen Cappuccino. Und du?

Anna: Ich nehme einen Latte Macchiato. Möchtest du ein Stück Kuchen?

Lukas: Ja, gerne! Welchen Kuchen empfiehlst du?

Anna: Der Apfelkuchen hier ist sehr lecker.

Lukas: Dann nehme ich ein Stück Apfelkuchen. Wie war dein Tag?

Anna: Mein Tag w')
 ''');
//     await db.execute('''
//   CREATE TABLE mistakes (
//     id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//     english TEXT NOT NULL,
//     arabic TEXT NOT NULL
//   )
// ''');
//     await db.execute('''
//   CREATE TABLE pictures (
//     id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//     the_picture
//   )
// ''');
//     await db.execute('''
//   CREATE TABLE storypictures (
//     for INTEGER NOT NULL REFERENCES stories (id),
//     from the_picture's_variable NOT NULL REFERENCES pictures (id),
//     no_of_reviews INTEGER NOT NULL,
//     english TEXT NOT NULL,
//     arabic TEXT NOT NULL
//   )
// ''');
    print("======DB has been created=======");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute('''
    //   CREATE TABLE monitored_apps(
    //   package_name TEXT)''');
    // await db.execute('''DROP TABLE monitored_apps''');
     
    // await db.execute('''
    //   CREATE TABLE snaps(
    //   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    //   no_of_reviews INTEGER NOT NULL,
    //   last_review_date DATE NOT NULL,
    //   next_review_date DATE NOT NULL,
    //   snap TEXT NOT NULL)''');
    print("======DB has been upgraded=======");
  }

  select(String sql) async {
    //SELECT
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response; //returns the selected rows' data
  }

  insert(String sql) async {
    //INSERT
    Database? mydb = await db;
    int response =
        await mydb!.rawInsert(sql); //returns 0:failure  no.of.row:done
    //mydb! <--  means you are sure that it is not null
    return response;
  }

  update(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  delete(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
