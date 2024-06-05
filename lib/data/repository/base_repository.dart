import 'package:homelinker/data/database/database.dart';
import 'package:homelinker/data/database/database_provider.dart';

abstract class BaseRepository {
  BaseRepository(this._databaseProvider);

  final DatabaseProvider _databaseProvider;

  AppDatabase get database => _databaseProvider.get;

  String get tableName;

  int get cachePeriod;

  Future<bool> isExpired({String additionalParam = ''}) async {
    final identifier = additionalParam.isNotEmpty ? '${tableName}_$additionalParam' : tableName;
    final tablesUpdateTime =
        await (database.select(database.tablesUpdateTimes)..where((t) => t.name.equals(identifier))).getSingleOrNull();

    if (tablesUpdateTime == null) {
      return true;
    }

    return DateTime.now().difference(tablesUpdateTime.lastUpdate) > Duration(minutes: cachePeriod);
  }

  Future<void> setLastUpdateNow({String additionalParam = ''}) async {
    final identifier = additionalParam.isNotEmpty ? '${tableName}_$additionalParam' : tableName;
    final tablesUpdateTime =
        await (database.select(database.tablesUpdateTimes)..where((t) => t.name.equals(identifier))).getSingleOrNull();

    final companion = TablesUpdateTimesCompanion.insert(name: identifier, lastUpdate: DateTime.now());
    if (tablesUpdateTime != null) {
      await (database.update(database.tablesUpdateTimes)..where((t) => t.name.equals(identifier))).write(companion);
    } else {
      await database.into(database.tablesUpdateTimes).insert(companion);
    }
  }

  Future<void> invalidateCache({String additionalParam = ''}) async {
    final identifier = additionalParam.isNotEmpty ? '${tableName}_$additionalParam' : tableName;

    final tablesUpdateTime =
        await (database.select(database.tablesUpdateTimes)..where((t) => t.name.equals(identifier))).getSingleOrNull();

    if (tablesUpdateTime == null) {
      return;
    }

    await (database.delete(database.tablesUpdateTimes)..where((t) => t.name.equals(identifier))).go();
  }
}
