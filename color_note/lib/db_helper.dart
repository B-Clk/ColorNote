import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'NotesPage.dart';
import 'notes_page.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, baslik TEXT, yazi TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertNote(NoteData note) async {
    Database db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<NoteData>> getNotes() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return NoteData(
        id: maps[i]['id'],
        baslik: maps[i]['baslik'],
        yazi: maps[i]['yazi'],
      );
    });
  }
}
