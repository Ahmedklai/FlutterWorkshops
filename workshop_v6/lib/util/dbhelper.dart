import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/trainings.dart';
import '../models/workshops_list.dart';

class DbHelper {
  final int version = 1;
  Database db;
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'workshops.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE workshops(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute(
            'CREATE TABLE trainings(id INTEGER PRIMARY KEY, idWorkshop INTEGER, name TEXT, trainer TEXT, note INTEGER, ' +
                'FOREIGN KEY(idWorkshop)REFERENCES workshops(id))');
      }, version: version);
    }
    return db;
  }

  Future<int> insertList(WorkshopsList list) async {
    int id = await this.db.insert(
          'workshops',
          list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<int> insertTraining(Training item) async {
    int id = await db.insert(
      'trainings',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<WorkshopsList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query('workshops');
    return List.generate(maps.length, (i) {
      return WorkshopsList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }
}
