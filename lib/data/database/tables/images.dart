import 'package:drift/drift.dart';

class Images extends Table {
  @override
  String? get tableName => 'images';

  TextColumn? get identifier => text()();

  TextColumn? get name => text()();

  TextColumn? get path => text()();

  DateTimeColumn? get uploadDate => dateTime()();

  BlobColumn? get data => blob()();
}
