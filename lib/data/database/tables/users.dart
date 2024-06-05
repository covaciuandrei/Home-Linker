import 'package:drift/drift.dart';

class Users extends Table {
  @override
  String? get tableName => 'users';

  TextColumn get id => text()();

  TextColumn get email => text()();

  TextColumn get name => text()();

  TextColumn get phone => text()();

  TextColumn get profilePictureId => text()();

  TextColumn get type => text()();

  BoolColumn get is2FaActivated => boolean()();
}
