import 'package:markbook/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE marks(id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT NOT NULL, done INTEGER NOT NULL, priority INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }
  Future<int> insertMark(List<MarkMapModel> marks) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var mark in marks){
      result = await db.insert('marks', mark.toMap());
    }
    return result;
  }
  Future<List<MarkMapModel>> retrieveMarks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('marks');
    return queryResult.map((e) => MarkMapModel.fromMap(e)).toList();
  }
  Future<void> deleteMark(int id) async {
    final db = await initializeDB();
    await db.delete(
      'marks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}