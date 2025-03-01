import 'dart:io';
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

  Future<List<Map<String,dynamic>>?> queryAll() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  Future<int?> insert(Map<String,dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table,row);
  }
}
