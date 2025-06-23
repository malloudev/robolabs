import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

abstract final class DatabaseWrapper {
  static late Database _db;

  static Future<void> ensureInitialized() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'robolabs.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        final batch = db.batch();

        batch.execute('CREATE TABLE IF NOT EXISTS userdata(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT)');
        batch.execute('CREATE TABLE IF NOT EXISTS courses(id INTEGER PRIMARY KEY AUTOINCREMENT)');
        batch.execute('CREATE TABLE IF NOT EXISTS preferences(id INTEGER PRIMARY KEY AUTOINCREMENT)');
        batch.execute('CREATE TABLE IF NOT EXISTS preferences(id INTEGER PRIMARY KEY AUTOINCREMENT)');

        await batch.commit();
      }
    );
  }

  static Future<List<Map<String, Object?>>> get(String table) {
    return _db.query(table);
  }

  static void enterUser(String name) {
    _db.insert('userdata', { 'username': name });
  }
}