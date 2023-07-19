import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/state/state.dart';
import 'package:salah_app/data/dog.dart';
import 'package:salah_app/models/dog.dart';

class DogsController {
  DogsController(this.ref);

  final Ref ref;

  Future<List<Dog>> fetchAll() async {
    final db = await ref.read(databaseProvider);
    return Dogs(db).fetchAll();
  }

  Future<Dog> fetch(int id) async {
    final db = await ref.read(databaseProvider);
    return Dogs(db).fetch(id);
  }

  Future<int> create(String name) async {
    final db = await ref.read(databaseProvider);
    return Dogs(db).create(name);
  }

  Future<int> update(int id, String name) async {
    final db = await ref.read(databaseProvider);
    return Dogs(db).update(id, name);
  }

  Future<int> delete(int id) async {
    final db = await ref.read(databaseProvider);
    return Dogs(db).delete(id);
  }
}
