import 'package:drift/drift.dart';

class TablesUpdateTimes extends Table {
  TextColumn get name => text()();

  DateTimeColumn get lastUpdate => dateTime()();
}
