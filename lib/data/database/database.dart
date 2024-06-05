import 'package:drift/drift.dart';
import 'package:homelinker/data/database/connection/connection.dart' as impl;
import 'package:homelinker/data/database/tables/expiration_times.dart';
import 'package:homelinker/data/database/tables/users.dart';

part 'database.g.dart';

const String databaseName = 'accountancy_db.sqlite';

@DriftDatabase(tables: [TablesUpdateTimes, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  Future<void> clear() async {
    for (final table in allTables) {
      await table.deleteAll();
    }
  }
}
