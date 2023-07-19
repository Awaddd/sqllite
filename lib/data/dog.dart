import 'package:salah_app/models/dog.dart';
import 'package:sqflite/sqflite.dart';

class Dogs {
  static String tableName = 'dogs';
  final Database? db;

  Dogs(this.db);

  static Future<void> createTable(Database database) async {
    await database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        );
      ''',
    );
  }

  Future<List<Dog>> fetchAll() async {
    final dogs = await db!.rawQuery(
      '''
        SELECT * FROM $tableName;
      ''',
    );

    return dogs.map((dog) => Dog.fromLocalDatabase(dog)).toList();
  }

  Future<Dog> fetch(int id) async {
    final dogs = await db!.rawQuery(
      '''
        SELECT *
        FROM $tableName
        WHERE id = "$id"
      ''',
    );

    for (final dog in dogs) {
      print('SQL dog ${dog['id']} ${dog['name']}');
    }

    return Dog.fromLocalDatabase(dogs.first);
  }

  Future<int> create(String name) async {
    return db!.rawInsert(
      '''
        INSERT INTO $tableName (name) VALUES (?)
      ''',
      [name],
    );
  }

  Future<int> update(int id, String name) async {
    return db!.rawUpdate(
      '''
        UPDATE $tableName
        SET name = "$name"
        WHERE id = "$id"
      ''',
    );
  }
}
