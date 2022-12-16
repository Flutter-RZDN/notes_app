import 'package:notes_app/model/notes_class.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesService {
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, create_at DATETIME, update_at DATETIME, title TEXT, content TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNote(NotesClass notesClass) async {
    Database database = await openDB();

    database.insert("notes", notesClass.toLocalDb());
  }

  static Future<List<NotesClass>> getAllNotes() async {
    Database database = await openDB();
    final response = await database.query("notes");
    final List<Map<String, dynamic>> maps = response;

    return List.generate(maps.length, (i) {
      return NotesClass(
        maps[i]['id'],
        maps[i]["create_at"],
        maps[i]["update_at"],
        maps[i]['title'],
        maps[i]['content'],
      );
    });
  }

  static Future<void> updateNote(NotesClass notesClass) async {
    Database database = await openDB();

    await database.update(
      "notes",
      notesClass.toLocalDb(),
      where: "id = ?",
      whereArgs: [notesClass.id],
    );
  }

  static Future<void> deleteNote(id) async {
    Database database = await openDB();

    await database.delete(
      "notes",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteDataBase() async {
    databaseFactory.deleteDatabase(
      join(await getDatabasesPath(), 'notes.db'),
    );
  }
}
