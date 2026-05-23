import 'package:drift/drift.dart';

class Properties extends Table {
  @override
  String? get tableName => 'properties';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get id => text()();

  IntColumn get areaSize => integer()();
  IntColumn get bathrooms => integer()();
  IntColumn get bedrooms => integer()();
  IntColumn get constructionYear => integer()();

  TextColumn get description => text()();

  TextColumn get imageId => text()();

  TextColumn get listingType => text()();

  TextColumn get location => text()();

  TextColumn get ownerEmail => text()();

  TextColumn get ownerName => text()();

  IntColumn get parkingSpaces => integer()();

  RealColumn get price => real()();

  TextColumn get propertyType => text()();
}
