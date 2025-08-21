import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../Model/Habit_Model/habit_model.dart';


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
            frequency TEXT,
            startDate TEXT,
            streak INTEGER,
            color INTEGER,
            iconCode INTEGER
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

  static Future<int> insertHabit(Habit habit) async {
    final db = await getDB();
    return await db.insert('habits', habit.toMap());
  }

  static Future<List<Habit>> getHabits() async {
    final db = await getDB();
    final maps = await db.query('habits');
    return maps.map((e) => Habit.fromMap(e)).toList();
  }
}