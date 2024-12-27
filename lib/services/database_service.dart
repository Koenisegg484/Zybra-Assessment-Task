import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/tasks_model.dart';

class DatabaseHelper {
  static const _databaseName = "task_database.db";
  static const _databaseVersion = 1;
  static const _tableName = "tasks";

  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    // Initialize the database
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        startDate TEXT,
        dueDate TEXT,
        priority TEXT,
        tags TEXT,
        status INTEGER NOT NULL DEFAULT 0,
        startTime TEXT
      )
    ''');
  }

  // Insert a task
  Future<int> insertTask(Task task) async {
    Database db = await database;
    int result = await db.insert(_tableName, task.toMap());
    return result;
  }

  // Get all tasks
  Future<List<Task>> getTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // Update a task
  Future<int> updateTask(Task task) async {
    Database db = await database;
    int result = await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  // Delete a task
  Future<int> deleteTask(int id) async {
    Database db = await database;
    int result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
