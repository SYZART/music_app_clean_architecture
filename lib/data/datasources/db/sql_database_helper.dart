import 'dart:async';

import 'package:openmusic/data/models/login_model.dart';
import 'package:sqflite/sqflite.dart';

class SQLDatabaseHelper {
  static SQLDatabaseHelper? _databaseHelper;
  SQLDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory SQLDatabaseHelper() =>
      _databaseHelper ?? SQLDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblUser = 'user';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/user.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblUser (
        id INTEGER PRIMARY KEY,
        accessToken TEXT,
        refreshToken TEXT
      );
    ''');
  }

  Future<int> insertUserToken(DataLoginModel loginModel) async {
    final db = await database;
    return await db!.insert(
      _tblUser,
      loginModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> readUserToken(String nameToken) async {
    final db = await database;
    final result = await db!
        .query(_tblUser, columns: [nameToken], where: 'id = ?', whereArgs: [1]);
    return result[0].values.toList()[0].toString();
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblUser);
    return results;
  }

  Future<int> clearUserTable() async {
    final db = await database;
    return await db!.rawDelete('DELETE FROM $_tblUser');
  }
}
