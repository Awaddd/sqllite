import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/state/state.dart';
import 'package:salah_app/data/cat.dart';
import 'package:sqflite/sqflite.dart';

class ApplicationController {
  ApplicationController(this.ref);

  final WidgetRef ref;

  Future<void> insertCat(Cat cat) async {
    final db = await ref.read(databaseProvider);

    await db.insert(
      'cats',
      cat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cat>> getAllCats() async {
    final db = await ref.read(databaseProvider);

    final List<Map<String, dynamic>> maps = await db.query('cats');

    return List.generate(maps.length, (i) {
      final cat = maps[i];
      return Cat(
        id: cat['id'] as int,
        name: cat['name'] as String,
      );
    });
  }
}
