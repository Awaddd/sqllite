import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:salah_app/data/dog.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider((ref) async {
  return openDatabase(
    join(await getDatabasesPath(), 'cat_database.db'),
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE cats(id INTEGER PRIMARY KEY, name TEXT)');
      await Dogs.createTable(db);
    },
    version: 1,
  );
});

final dogsTextControllers =
    StateProvider<Map<int, TextEditingController>>((ref) => {});
