// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TablesUpdateTimesTable extends TablesUpdateTimes
    with TableInfo<$TablesUpdateTimesTable, TablesUpdateTime> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TablesUpdateTimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, lastUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tables_update_times';
  @override
  VerificationContext validateIntegrity(Insertable<TablesUpdateTime> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TablesUpdateTime map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TablesUpdateTime(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update'])!,
    );
  }

  @override
  $TablesUpdateTimesTable createAlias(String alias) {
    return $TablesUpdateTimesTable(attachedDatabase, alias);
  }
}

class TablesUpdateTime extends DataClass
    implements Insertable<TablesUpdateTime> {
  final String name;
  final DateTime lastUpdate;
  const TablesUpdateTime({required this.name, required this.lastUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  TablesUpdateTimesCompanion toCompanion(bool nullToAbsent) {
    return TablesUpdateTimesCompanion(
      name: Value(name),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory TablesUpdateTime.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TablesUpdateTime(
      name: serializer.fromJson<String>(json['name']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  TablesUpdateTime copyWith({String? name, DateTime? lastUpdate}) =>
      TablesUpdateTime(
        name: name ?? this.name,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('TablesUpdateTime(')
          ..write('name: $name, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TablesUpdateTime &&
          other.name == this.name &&
          other.lastUpdate == this.lastUpdate);
}

class TablesUpdateTimesCompanion extends UpdateCompanion<TablesUpdateTime> {
  final Value<String> name;
  final Value<DateTime> lastUpdate;
  final Value<int> rowid;
  const TablesUpdateTimesCompanion({
    this.name = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TablesUpdateTimesCompanion.insert({
    required String name,
    required DateTime lastUpdate,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        lastUpdate = Value(lastUpdate);
  static Insertable<TablesUpdateTime> custom({
    Expression<String>? name,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TablesUpdateTimesCompanion copyWith(
      {Value<String>? name, Value<DateTime>? lastUpdate, Value<int>? rowid}) {
    return TablesUpdateTimesCompanion(
      name: name ?? this.name,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TablesUpdateTimesCompanion(')
          ..write('name: $name, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _profilePictureIdMeta =
      const VerificationMeta('profilePictureId');
  @override
  late final GeneratedColumn<String> profilePictureId = GeneratedColumn<String>(
      'profile_picture_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _is2FaActivatedMeta =
      const VerificationMeta('is2FaActivated');
  @override
  late final GeneratedColumn<bool> is2FaActivated = GeneratedColumn<bool>(
      'is2_fa_activated', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is2_fa_activated" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, email, name, phone, profilePictureId, type, is2FaActivated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('profile_picture_id')) {
      context.handle(
          _profilePictureIdMeta,
          profilePictureId.isAcceptableOrUnknown(
              data['profile_picture_id']!, _profilePictureIdMeta));
    } else if (isInserting) {
      context.missing(_profilePictureIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is2_fa_activated')) {
      context.handle(
          _is2FaActivatedMeta,
          is2FaActivated.isAcceptableOrUnknown(
              data['is2_fa_activated']!, _is2FaActivatedMeta));
    } else if (isInserting) {
      context.missing(_is2FaActivatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      profilePictureId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_picture_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      is2FaActivated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is2_fa_activated'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String profilePictureId;
  final String type;
  final bool is2FaActivated;
  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.profilePictureId,
      required this.type,
      required this.is2FaActivated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['profile_picture_id'] = Variable<String>(profilePictureId);
    map['type'] = Variable<String>(type);
    map['is2_fa_activated'] = Variable<bool>(is2FaActivated);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      name: Value(name),
      phone: Value(phone),
      profilePictureId: Value(profilePictureId),
      type: Value(type),
      is2FaActivated: Value(is2FaActivated),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      profilePictureId: serializer.fromJson<String>(json['profilePictureId']),
      type: serializer.fromJson<String>(json['type']),
      is2FaActivated: serializer.fromJson<bool>(json['is2FaActivated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'profilePictureId': serializer.toJson<String>(profilePictureId),
      'type': serializer.toJson<String>(type),
      'is2FaActivated': serializer.toJson<bool>(is2FaActivated),
    };
  }

  User copyWith(
          {String? id,
          String? email,
          String? name,
          String? phone,
          String? profilePictureId,
          String? type,
          bool? is2FaActivated}) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        profilePictureId: profilePictureId ?? this.profilePictureId,
        type: type ?? this.type,
        is2FaActivated: is2FaActivated ?? this.is2FaActivated,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('profilePictureId: $profilePictureId, ')
          ..write('type: $type, ')
          ..write('is2FaActivated: $is2FaActivated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, email, name, phone, profilePictureId, type, is2FaActivated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.profilePictureId == this.profilePictureId &&
          other.type == this.type &&
          other.is2FaActivated == this.is2FaActivated);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> profilePictureId;
  final Value<String> type;
  final Value<bool> is2FaActivated;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.profilePictureId = const Value.absent(),
    this.type = const Value.absent(),
    this.is2FaActivated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String email,
    required String name,
    required String phone,
    required String profilePictureId,
    required String type,
    required bool is2FaActivated,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        name = Value(name),
        phone = Value(phone),
        profilePictureId = Value(profilePictureId),
        type = Value(type),
        is2FaActivated = Value(is2FaActivated);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? profilePictureId,
    Expression<String>? type,
    Expression<bool>? is2FaActivated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (profilePictureId != null) 'profile_picture_id': profilePictureId,
      if (type != null) 'type': type,
      if (is2FaActivated != null) 'is2_fa_activated': is2FaActivated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? email,
      Value<String>? name,
      Value<String>? phone,
      Value<String>? profilePictureId,
      Value<String>? type,
      Value<bool>? is2FaActivated,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profilePictureId: profilePictureId ?? this.profilePictureId,
      type: type ?? this.type,
      is2FaActivated: is2FaActivated ?? this.is2FaActivated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (profilePictureId.present) {
      map['profile_picture_id'] = Variable<String>(profilePictureId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (is2FaActivated.present) {
      map['is2_fa_activated'] = Variable<bool>(is2FaActivated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('profilePictureId: $profilePictureId, ')
          ..write('type: $type, ')
          ..write('is2FaActivated: $is2FaActivated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TablesUpdateTimesTable tablesUpdateTimes =
      $TablesUpdateTimesTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tablesUpdateTimes, users];
}
