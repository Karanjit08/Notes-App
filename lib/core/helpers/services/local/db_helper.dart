import 'dart:io';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databasename = "notes.db";
  static final _databaseversion = 1;
  static final table = "my_table";
  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnSubtitle = 'subtitle';
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
      $columnSubtitle TEXT NOT NULL
    )
    ''');
  }



  // FUNCTIONS TO CREATE, READ, UPDATE, DELETE data from Database

  Future<List<NotesModel>?> queryAll() async {
    Database? db = await instance.database;
    final List<Map<String,dynamic>>? myNotes = await db?.query(table);
    return myNotes?.map((map) => NotesModel.fromMap(map)).toList();
  }

  Future<int?> insert(NotesModel notesModel) async {
    Database? db = await instance.database;
    return await db?.insert(table,notesModel.toMap());
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    var res = await db?.delete(table,where: "id = ?",whereArgs: [id]);
    return res;
  }

  Future<int?> update(int id, NotesModel notesModel) async {
    Database? db = await instance.database;
    var res = await db?.update(table, notesModel.toMap(),where: "id = ?",whereArgs: [id]);
    return res;
  }
}
