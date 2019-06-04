import 'package:flutter/material.dart';
import 'package:nature_journal/entry_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

Future getDatabase() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'entries_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE entries(title TEXT, location Text, description TEXT, date TEXT, hour INTEGER, minute INTEGER, imageFile TEXT)",
      );
    },
    version: 4,
    onUpgrade: _onUpgrade,
  );
  return database;
}

void _onUpgrade(Database db, int oldVersion, int newVersion) {
  if (oldVersion < newVersion) {
    db.execute("DROP TABLE entries;");
    db.execute(
        "CREATE TABLE entries(title TEXT, location Text, description TEXT, date TEXT, hour INTEGER, minute INTEGER, imageFile TEXT);");
  }
}

Future<void> insertEntry(Entry entry) async {
  final Database db = await getDatabase();
  await db.insert(
    'entries',
    entry.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<List<Entry>> entries() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('entries');
  return List.generate(maps.length, (i) {
    return Entry(
      maps[i]['title'],
      maps[i]['location'],
      maps[i]['description'],
      DateTime.parse(maps[i]['date']),
      TimeOfDay(
        hour: maps[i]['hour'],
        minute: maps[i]['minute'],
      ),
      maps[i]['imageFile'],
    );
  });
}

Future<void> updateEntry(Entry entry) async {
  final db = await getDatabase();

  await db.update(
    'entries',
    entry.toMap(),
    where: "title = ?",
    whereArgs: [entry.title],
  );
}

Future<void> deleteEntry(String title) async {
  final db = await getDatabase();

  await db.delete(
    'entries',
    where: "title = ?",
    whereArgs: [title],
  );
}
