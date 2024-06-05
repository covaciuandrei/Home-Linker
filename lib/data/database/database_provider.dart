import 'package:homelinker/data/database/database.dart';
import 'package:injectable/injectable.dart';

@singleton
class DatabaseProvider {
  AppDatabase? _databaseInstance;

  AppDatabase get get {
    _databaseInstance ??= AppDatabase();
    return _databaseInstance!;
  }
}
