import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db; //we need it to not run initialDb() in every query
  Future<Database?> get db async {
    //*Future* bcs async and need to wait
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
    String path = join(databasepath, 'wordup.db'); //naming our db
    await deleteDatabase(path);

    print("======DB has been deleted=======");
  }

  initialDb() async {
    String databasepath =
        await getDatabasesPath(); //path of the db on ur device
    String path = join(databasepath, 'wordup.db'); //naming our db
    Database wordupdb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    //creating our db
    //version==1 means: just created, still never updated
    //when version==1: onCreate will be called (it get called only once)
    //each time the value of 'version' differs, onUpgrade is called
    return wordupdb;
  }

  _onCreate(Database db, int version) async {
    // creates db's tabels
    //this function runs only for one time
    //after that if you need to edit db architecture you will use onUpgrade
    //*this function can create only one table:
    await db.execute('''
  CREATE TABLE stories (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    story_level INTEGER NOT NULL,
    title TEXT NOT NULL,
    text TEXT NOT NULL
  )
''');
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
    await db.execute('''
  CREATE TABLE words (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    story_id INTEGER NOT NULL REFERENCES stories (id),
    no_of_reviews INTEGER NOT NULL,
    english TEXT NOT NULL,
    arabic TEXT NOT NULL
  )
''');
    await db.execute('''
  CREATE TABLE mistakes (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    english TEXT NOT NULL,
    arabic TEXT NOT NULL
  )
''');
    await db.execute('''
  CREATE TABLE stats (
    no_of_words INTEGER,
    no_of_quizzes INTEGER,
    no_of_stories_added INTEGER,
    no_of_curr_stories INTEGER,
    highest_correct_streak INTEGER,
    highest_streak  INTEGER
    id INTEGER 
  )
''');
    print("======DB has been created=======");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    await db.execute('''
    INSERT INTO stats 
    values (0,0,0,0,0,0,0)
 ''');


//       await db.execute('''
//     ALTER TABLE words
//     ADD id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT 
//  ''');
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
