// ignore_for_file: avoid_print

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'app_db.g.dart';

class Movie extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
}

@DriftDatabase(tables: [Movie])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //Function to get the employeedata
  Future<List<MovieData>> getEmployess() async {
    return await select(movie).get();
  }

  Future<MovieData> getMovie(id) async {
    return await (select(movie)..where((tbl) => tbl.id.equals(id as String)))
        .getSingle();
  }

  Future<int> inserMovie(MovieCompanion entity) async {
    return await into(movie).insert(entity);
  }

  Future<int> deleteMovie(id) async {
    return await (delete(movie)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    print(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
