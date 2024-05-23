import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const _tableName = 'todos';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'todos_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id TEXT PRIMARY KEY,
            todoText TEXT,
            isDone INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertTodo(Map<String, dynamic> todo) async {
    final db = await database;
    await db.insert(_tableName, todo);
  }

  Future<List<Map<String, dynamic>>> getAllTodos() async {
    final db = await database;
    return await db.query(_tableName);
  }

  Future<void> updateTodo(Map<String, dynamic> todo) async {
    final db = await database;
    await db.update(
      _tableName,
      todo,
      where: 'id = ?',
      whereArgs: [todo['id']],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
