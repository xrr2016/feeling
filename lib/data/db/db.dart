import 'package:sqflite/sqflite.dart';

class Db {
  Database instance;

  Future open(String path) async {
    instance = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
        );
      },
    );
  }

  Future close() async => instance.close();
}
