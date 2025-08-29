import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class HabitDB {
  static Database? _db;

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'habits.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE habits(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            icon INTEGER,
            color INTEGER,
            frequency TEXT,
            start_Date TEXT,
            end_Date TEXT,
            streak INTEGER,
            isCheck INTEGER,
            selectedDate TEXT,
            iconFontFamily TEXT
          )
        ''');
        await db.execute('''
    CREATE TABLE habit_completions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      habit_id INTEGER,
      date TEXT,
      streak INTEGER,
      isCheck INTEGER,
      FOREIGN KEY(habit_id) REFERENCES habits(id) ON DELETE CASCADE
    )
  ''');
      },
      version: 1,
    );
  }

  static Future<Database> getDB() async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<int> insertHabit(Map<String, dynamic> row) async {
    final db = await getDB();
    return await db.insert('habits', row);
  }

  static  Future<List<Map<String, dynamic>>>getHabits() async {
    final db = await getDB();
    return await db.query('habits');
  }

  static  Future<void>updateDb(int id, int isCheck) async {
    final db = await getDB();
     await db.update('habits', {'isCheck':isCheck},where: 'id = ?',whereArgs: [id]);
  }

  // Future<List<Map<String, dynamic>>> readDb() async {
  //   Database db = await dbHero.dataBase;
  //   return await db.query('user_table');
  // }
  static Future<void> habitCompletion(int habitId, String date,int streak) async {
    final db = await getDB();

    final res = await db.query(
      'habit_completions',
      where: 'habit_id = ? AND date = ?',
      whereArgs: [habitId, date],
    );

    if (res.isEmpty) {
      int newStreak = streak + 1;

      await db.insert('habit_completions', {
        'habit_id': habitId,
        'date': date,
        'streak':newStreak,
        'isCheck': 1,
      });
    } else {
      final current = res.first['isCheck'] as int;
      await db.update(
        'habit_completions',
        {'isCheck': current == 1 ? 0 : 1},
        where: 'habit_id = ? AND date = ?',
        whereArgs: [habitId, date],
      );
    }
  }

  static Future<bool> isHabitCompleted(int habitId, String date) async {
    final db = await getDB();
    final res = await db.query(
      'habit_completions',
      where: 'habit_id = ? AND date = ? AND isCheck = 1',
      whereArgs: [habitId, date],
    );
    return res.isNotEmpty;
  }


}



