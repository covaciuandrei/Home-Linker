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
  static const VerificationMeta _twoFactorAuthCodeMeta =
      const VerificationMeta('twoFactorAuthCode');
  @override
  late final GeneratedColumn<String> twoFactorAuthCode =
      GeneratedColumn<String>('two_factor_auth_code', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        name,
        phone,
        profilePictureId,
        type,
        is2FaActivated,
        twoFactorAuthCode
      ];
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
    if (data.containsKey('two_factor_auth_code')) {
      context.handle(
          _twoFactorAuthCodeMeta,
          twoFactorAuthCode.isAcceptableOrUnknown(
              data['two_factor_auth_code']!, _twoFactorAuthCodeMeta));
    } else if (isInserting) {
      context.missing(_twoFactorAuthCodeMeta);
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
      twoFactorAuthCode: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}two_factor_auth_code'])!,
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
  final String twoFactorAuthCode;
  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.profilePictureId,
      required this.type,
      required this.is2FaActivated,
      required this.twoFactorAuthCode});
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
    map['two_factor_auth_code'] = Variable<String>(twoFactorAuthCode);
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
      twoFactorAuthCode: Value(twoFactorAuthCode),
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
      twoFactorAuthCode: serializer.fromJson<String>(json['twoFactorAuthCode']),
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
      'twoFactorAuthCode': serializer.toJson<String>(twoFactorAuthCode),
    };
  }

  User copyWith(
          {String? id,
          String? email,
          String? name,
          String? phone,
          String? profilePictureId,
          String? type,
          bool? is2FaActivated,
          String? twoFactorAuthCode}) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        profilePictureId: profilePictureId ?? this.profilePictureId,
        type: type ?? this.type,
        is2FaActivated: is2FaActivated ?? this.is2FaActivated,
        twoFactorAuthCode: twoFactorAuthCode ?? this.twoFactorAuthCode,
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
          ..write('is2FaActivated: $is2FaActivated, ')
          ..write('twoFactorAuthCode: $twoFactorAuthCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, name, phone, profilePictureId,
      type, is2FaActivated, twoFactorAuthCode);
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
          other.is2FaActivated == this.is2FaActivated &&
          other.twoFactorAuthCode == this.twoFactorAuthCode);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> profilePictureId;
  final Value<String> type;
  final Value<bool> is2FaActivated;
  final Value<String> twoFactorAuthCode;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.profilePictureId = const Value.absent(),
    this.type = const Value.absent(),
    this.is2FaActivated = const Value.absent(),
    this.twoFactorAuthCode = const Value.absent(),
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
    required String twoFactorAuthCode,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        name = Value(name),
        phone = Value(phone),
        profilePictureId = Value(profilePictureId),
        type = Value(type),
        is2FaActivated = Value(is2FaActivated),
        twoFactorAuthCode = Value(twoFactorAuthCode);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? profilePictureId,
    Expression<String>? type,
    Expression<bool>? is2FaActivated,
    Expression<String>? twoFactorAuthCode,
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
      if (twoFactorAuthCode != null) 'two_factor_auth_code': twoFactorAuthCode,
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
      Value<String>? twoFactorAuthCode,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profilePictureId: profilePictureId ?? this.profilePictureId,
      type: type ?? this.type,
      is2FaActivated: is2FaActivated ?? this.is2FaActivated,
      twoFactorAuthCode: twoFactorAuthCode ?? this.twoFactorAuthCode,
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
    if (twoFactorAuthCode.present) {
      map['two_factor_auth_code'] = Variable<String>(twoFactorAuthCode.value);
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
          ..write('twoFactorAuthCode: $twoFactorAuthCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaSizeMeta =
      const VerificationMeta('areaSize');
  @override
  late final GeneratedColumn<int> areaSize = GeneratedColumn<int>(
      'area_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bathroomsMeta =
      const VerificationMeta('bathrooms');
  @override
  late final GeneratedColumn<int> bathrooms = GeneratedColumn<int>(
      'bathrooms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bedroomsMeta =
      const VerificationMeta('bedrooms');
  @override
  late final GeneratedColumn<int> bedrooms = GeneratedColumn<int>(
      'bedrooms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _constructionYearMeta =
      const VerificationMeta('constructionYear');
  @override
  late final GeneratedColumn<int> constructionYear = GeneratedColumn<int>(
      'construction_year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<String> imageId = GeneratedColumn<String>(
      'image_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _listingTypeMeta =
      const VerificationMeta('listingType');
  @override
  late final GeneratedColumn<String> listingType = GeneratedColumn<String>(
      'listing_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerEmailMeta =
      const VerificationMeta('ownerEmail');
  @override
  late final GeneratedColumn<String> ownerEmail = GeneratedColumn<String>(
      'owner_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parkingSpacesMeta =
      const VerificationMeta('parkingSpaces');
  @override
  late final GeneratedColumn<int> parkingSpaces = GeneratedColumn<int>(
      'parking_spaces', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _propertyTypeMeta =
      const VerificationMeta('propertyType');
  @override
  late final GeneratedColumn<String> propertyType = GeneratedColumn<String>(
      'property_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        areaSize,
        bathrooms,
        bedrooms,
        constructionYear,
        description,
        imageId,
        listingType,
        location,
        ownerEmail,
        ownerName,
        parkingSpaces,
        price,
        propertyType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(Insertable<Property> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('area_size')) {
      context.handle(_areaSizeMeta,
          areaSize.isAcceptableOrUnknown(data['area_size']!, _areaSizeMeta));
    } else if (isInserting) {
      context.missing(_areaSizeMeta);
    }
    if (data.containsKey('bathrooms')) {
      context.handle(_bathroomsMeta,
          bathrooms.isAcceptableOrUnknown(data['bathrooms']!, _bathroomsMeta));
    } else if (isInserting) {
      context.missing(_bathroomsMeta);
    }
    if (data.containsKey('bedrooms')) {
      context.handle(_bedroomsMeta,
          bedrooms.isAcceptableOrUnknown(data['bedrooms']!, _bedroomsMeta));
    } else if (isInserting) {
      context.missing(_bedroomsMeta);
    }
    if (data.containsKey('construction_year')) {
      context.handle(
          _constructionYearMeta,
          constructionYear.isAcceptableOrUnknown(
              data['construction_year']!, _constructionYearMeta));
    } else if (isInserting) {
      context.missing(_constructionYearMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    } else if (isInserting) {
      context.missing(_imageIdMeta);
    }
    if (data.containsKey('listing_type')) {
      context.handle(
          _listingTypeMeta,
          listingType.isAcceptableOrUnknown(
              data['listing_type']!, _listingTypeMeta));
    } else if (isInserting) {
      context.missing(_listingTypeMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('owner_email')) {
      context.handle(
          _ownerEmailMeta,
          ownerEmail.isAcceptableOrUnknown(
              data['owner_email']!, _ownerEmailMeta));
    } else if (isInserting) {
      context.missing(_ownerEmailMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('parking_spaces')) {
      context.handle(
          _parkingSpacesMeta,
          parkingSpaces.isAcceptableOrUnknown(
              data['parking_spaces']!, _parkingSpacesMeta));
    } else if (isInserting) {
      context.missing(_parkingSpacesMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('property_type')) {
      context.handle(
          _propertyTypeMeta,
          propertyType.isAcceptableOrUnknown(
              data['property_type']!, _propertyTypeMeta));
    } else if (isInserting) {
      context.missing(_propertyTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      areaSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}area_size'])!,
      bathrooms: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bathrooms'])!,
      bedrooms: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bedrooms'])!,
      constructionYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}construction_year'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_id'])!,
      listingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}listing_type'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      ownerEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_email'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name'])!,
      parkingSpaces: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parking_spaces'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      propertyType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_type'])!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final String id;
  final int areaSize;
  final int bathrooms;
  final int bedrooms;
  final int constructionYear;
  final String description;
  final String imageId;
  final String listingType;
  final String location;
  final String ownerEmail;
  final String ownerName;
  final int parkingSpaces;
  final double price;
  final String propertyType;
  const Property(
      {required this.id,
      required this.areaSize,
      required this.bathrooms,
      required this.bedrooms,
      required this.constructionYear,
      required this.description,
      required this.imageId,
      required this.listingType,
      required this.location,
      required this.ownerEmail,
      required this.ownerName,
      required this.parkingSpaces,
      required this.price,
      required this.propertyType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['area_size'] = Variable<int>(areaSize);
    map['bathrooms'] = Variable<int>(bathrooms);
    map['bedrooms'] = Variable<int>(bedrooms);
    map['construction_year'] = Variable<int>(constructionYear);
    map['description'] = Variable<String>(description);
    map['image_id'] = Variable<String>(imageId);
    map['listing_type'] = Variable<String>(listingType);
    map['location'] = Variable<String>(location);
    map['owner_email'] = Variable<String>(ownerEmail);
    map['owner_name'] = Variable<String>(ownerName);
    map['parking_spaces'] = Variable<int>(parkingSpaces);
    map['price'] = Variable<double>(price);
    map['property_type'] = Variable<String>(propertyType);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      areaSize: Value(areaSize),
      bathrooms: Value(bathrooms),
      bedrooms: Value(bedrooms),
      constructionYear: Value(constructionYear),
      description: Value(description),
      imageId: Value(imageId),
      listingType: Value(listingType),
      location: Value(location),
      ownerEmail: Value(ownerEmail),
      ownerName: Value(ownerName),
      parkingSpaces: Value(parkingSpaces),
      price: Value(price),
      propertyType: Value(propertyType),
    );
  }

  factory Property.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<String>(json['id']),
      areaSize: serializer.fromJson<int>(json['areaSize']),
      bathrooms: serializer.fromJson<int>(json['bathrooms']),
      bedrooms: serializer.fromJson<int>(json['bedrooms']),
      constructionYear: serializer.fromJson<int>(json['constructionYear']),
      description: serializer.fromJson<String>(json['description']),
      imageId: serializer.fromJson<String>(json['imageId']),
      listingType: serializer.fromJson<String>(json['listingType']),
      location: serializer.fromJson<String>(json['location']),
      ownerEmail: serializer.fromJson<String>(json['ownerEmail']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      parkingSpaces: serializer.fromJson<int>(json['parkingSpaces']),
      price: serializer.fromJson<double>(json['price']),
      propertyType: serializer.fromJson<String>(json['propertyType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'areaSize': serializer.toJson<int>(areaSize),
      'bathrooms': serializer.toJson<int>(bathrooms),
      'bedrooms': serializer.toJson<int>(bedrooms),
      'constructionYear': serializer.toJson<int>(constructionYear),
      'description': serializer.toJson<String>(description),
      'imageId': serializer.toJson<String>(imageId),
      'listingType': serializer.toJson<String>(listingType),
      'location': serializer.toJson<String>(location),
      'ownerEmail': serializer.toJson<String>(ownerEmail),
      'ownerName': serializer.toJson<String>(ownerName),
      'parkingSpaces': serializer.toJson<int>(parkingSpaces),
      'price': serializer.toJson<double>(price),
      'propertyType': serializer.toJson<String>(propertyType),
    };
  }

  Property copyWith(
          {String? id,
          int? areaSize,
          int? bathrooms,
          int? bedrooms,
          int? constructionYear,
          String? description,
          String? imageId,
          String? listingType,
          String? location,
          String? ownerEmail,
          String? ownerName,
          int? parkingSpaces,
          double? price,
          String? propertyType}) =>
      Property(
        id: id ?? this.id,
        areaSize: areaSize ?? this.areaSize,
        bathrooms: bathrooms ?? this.bathrooms,
        bedrooms: bedrooms ?? this.bedrooms,
        constructionYear: constructionYear ?? this.constructionYear,
        description: description ?? this.description,
        imageId: imageId ?? this.imageId,
        listingType: listingType ?? this.listingType,
        location: location ?? this.location,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        ownerName: ownerName ?? this.ownerName,
        parkingSpaces: parkingSpaces ?? this.parkingSpaces,
        price: price ?? this.price,
        propertyType: propertyType ?? this.propertyType,
      );
  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('areaSize: $areaSize, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('constructionYear: $constructionYear, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('listingType: $listingType, ')
          ..write('location: $location, ')
          ..write('ownerEmail: $ownerEmail, ')
          ..write('ownerName: $ownerName, ')
          ..write('parkingSpaces: $parkingSpaces, ')
          ..write('price: $price, ')
          ..write('propertyType: $propertyType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      areaSize,
      bathrooms,
      bedrooms,
      constructionYear,
      description,
      imageId,
      listingType,
      location,
      ownerEmail,
      ownerName,
      parkingSpaces,
      price,
      propertyType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.areaSize == this.areaSize &&
          other.bathrooms == this.bathrooms &&
          other.bedrooms == this.bedrooms &&
          other.constructionYear == this.constructionYear &&
          other.description == this.description &&
          other.imageId == this.imageId &&
          other.listingType == this.listingType &&
          other.location == this.location &&
          other.ownerEmail == this.ownerEmail &&
          other.ownerName == this.ownerName &&
          other.parkingSpaces == this.parkingSpaces &&
          other.price == this.price &&
          other.propertyType == this.propertyType);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<int> areaSize;
  final Value<int> bathrooms;
  final Value<int> bedrooms;
  final Value<int> constructionYear;
  final Value<String> description;
  final Value<String> imageId;
  final Value<String> listingType;
  final Value<String> location;
  final Value<String> ownerEmail;
  final Value<String> ownerName;
  final Value<int> parkingSpaces;
  final Value<double> price;
  final Value<String> propertyType;
  final Value<int> rowid;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.areaSize = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.constructionYear = const Value.absent(),
    this.description = const Value.absent(),
    this.imageId = const Value.absent(),
    this.listingType = const Value.absent(),
    this.location = const Value.absent(),
    this.ownerEmail = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.parkingSpaces = const Value.absent(),
    this.price = const Value.absent(),
    this.propertyType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertiesCompanion.insert({
    required String id,
    required int areaSize,
    required int bathrooms,
    required int bedrooms,
    required int constructionYear,
    required String description,
    required String imageId,
    required String listingType,
    required String location,
    required String ownerEmail,
    required String ownerName,
    required int parkingSpaces,
    required double price,
    required String propertyType,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        areaSize = Value(areaSize),
        bathrooms = Value(bathrooms),
        bedrooms = Value(bedrooms),
        constructionYear = Value(constructionYear),
        description = Value(description),
        imageId = Value(imageId),
        listingType = Value(listingType),
        location = Value(location),
        ownerEmail = Value(ownerEmail),
        ownerName = Value(ownerName),
        parkingSpaces = Value(parkingSpaces),
        price = Value(price),
        propertyType = Value(propertyType);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<int>? areaSize,
    Expression<int>? bathrooms,
    Expression<int>? bedrooms,
    Expression<int>? constructionYear,
    Expression<String>? description,
    Expression<String>? imageId,
    Expression<String>? listingType,
    Expression<String>? location,
    Expression<String>? ownerEmail,
    Expression<String>? ownerName,
    Expression<int>? parkingSpaces,
    Expression<double>? price,
    Expression<String>? propertyType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (areaSize != null) 'area_size': areaSize,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (constructionYear != null) 'construction_year': constructionYear,
      if (description != null) 'description': description,
      if (imageId != null) 'image_id': imageId,
      if (listingType != null) 'listing_type': listingType,
      if (location != null) 'location': location,
      if (ownerEmail != null) 'owner_email': ownerEmail,
      if (ownerName != null) 'owner_name': ownerName,
      if (parkingSpaces != null) 'parking_spaces': parkingSpaces,
      if (price != null) 'price': price,
      if (propertyType != null) 'property_type': propertyType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertiesCompanion copyWith(
      {Value<String>? id,
      Value<int>? areaSize,
      Value<int>? bathrooms,
      Value<int>? bedrooms,
      Value<int>? constructionYear,
      Value<String>? description,
      Value<String>? imageId,
      Value<String>? listingType,
      Value<String>? location,
      Value<String>? ownerEmail,
      Value<String>? ownerName,
      Value<int>? parkingSpaces,
      Value<double>? price,
      Value<String>? propertyType,
      Value<int>? rowid}) {
    return PropertiesCompanion(
      id: id ?? this.id,
      areaSize: areaSize ?? this.areaSize,
      bathrooms: bathrooms ?? this.bathrooms,
      bedrooms: bedrooms ?? this.bedrooms,
      constructionYear: constructionYear ?? this.constructionYear,
      description: description ?? this.description,
      imageId: imageId ?? this.imageId,
      listingType: listingType ?? this.listingType,
      location: location ?? this.location,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerName: ownerName ?? this.ownerName,
      parkingSpaces: parkingSpaces ?? this.parkingSpaces,
      price: price ?? this.price,
      propertyType: propertyType ?? this.propertyType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (areaSize.present) {
      map['area_size'] = Variable<int>(areaSize.value);
    }
    if (bathrooms.present) {
      map['bathrooms'] = Variable<int>(bathrooms.value);
    }
    if (bedrooms.present) {
      map['bedrooms'] = Variable<int>(bedrooms.value);
    }
    if (constructionYear.present) {
      map['construction_year'] = Variable<int>(constructionYear.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (listingType.present) {
      map['listing_type'] = Variable<String>(listingType.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (ownerEmail.present) {
      map['owner_email'] = Variable<String>(ownerEmail.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (parkingSpaces.present) {
      map['parking_spaces'] = Variable<int>(parkingSpaces.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (propertyType.present) {
      map['property_type'] = Variable<String>(propertyType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('areaSize: $areaSize, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('constructionYear: $constructionYear, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('listingType: $listingType, ')
          ..write('location: $location, ')
          ..write('ownerEmail: $ownerEmail, ')
          ..write('ownerName: $ownerName, ')
          ..write('parkingSpaces: $parkingSpaces, ')
          ..write('price: $price, ')
          ..write('propertyType: $propertyType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _identifierMeta =
      const VerificationMeta('identifier');
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
      'identifier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uploadDateMeta =
      const VerificationMeta('uploadDate');
  @override
  late final GeneratedColumn<DateTime> uploadDate = GeneratedColumn<DateTime>(
      'upload_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
      'data', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [identifier, name, path, uploadDate, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(Insertable<Image> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('identifier')) {
      context.handle(
          _identifierMeta,
          identifier.isAcceptableOrUnknown(
              data['identifier']!, _identifierMeta));
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('upload_date')) {
      context.handle(
          _uploadDateMeta,
          uploadDate.isAcceptableOrUnknown(
              data['upload_date']!, _uploadDateMeta));
    } else if (isInserting) {
      context.missing(_uploadDateMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      identifier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}identifier'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      uploadDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}upload_date'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final String identifier;
  final String name;
  final String path;
  final DateTime uploadDate;
  final Uint8List data;
  const Image(
      {required this.identifier,
      required this.name,
      required this.path,
      required this.uploadDate,
      required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['identifier'] = Variable<String>(identifier);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['upload_date'] = Variable<DateTime>(uploadDate);
    map['data'] = Variable<Uint8List>(data);
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      identifier: Value(identifier),
      name: Value(name),
      path: Value(path),
      uploadDate: Value(uploadDate),
      data: Value(data),
    );
  }

  factory Image.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      identifier: serializer.fromJson<String>(json['identifier']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      uploadDate: serializer.fromJson<DateTime>(json['uploadDate']),
      data: serializer.fromJson<Uint8List>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'identifier': serializer.toJson<String>(identifier),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'uploadDate': serializer.toJson<DateTime>(uploadDate),
      'data': serializer.toJson<Uint8List>(data),
    };
  }

  Image copyWith(
          {String? identifier,
          String? name,
          String? path,
          DateTime? uploadDate,
          Uint8List? data}) =>
      Image(
        identifier: identifier ?? this.identifier,
        name: name ?? this.name,
        path: path ?? this.path,
        uploadDate: uploadDate ?? this.uploadDate,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('identifier: $identifier, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('uploadDate: $uploadDate, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      identifier, name, path, uploadDate, $driftBlobEquality.hash(data));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.identifier == this.identifier &&
          other.name == this.name &&
          other.path == this.path &&
          other.uploadDate == this.uploadDate &&
          $driftBlobEquality.equals(other.data, this.data));
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<String> identifier;
  final Value<String> name;
  final Value<String> path;
  final Value<DateTime> uploadDate;
  final Value<Uint8List> data;
  final Value<int> rowid;
  const ImagesCompanion({
    this.identifier = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.uploadDate = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImagesCompanion.insert({
    required String identifier,
    required String name,
    required String path,
    required DateTime uploadDate,
    required Uint8List data,
    this.rowid = const Value.absent(),
  })  : identifier = Value(identifier),
        name = Value(name),
        path = Value(path),
        uploadDate = Value(uploadDate),
        data = Value(data);
  static Insertable<Image> custom({
    Expression<String>? identifier,
    Expression<String>? name,
    Expression<String>? path,
    Expression<DateTime>? uploadDate,
    Expression<Uint8List>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (identifier != null) 'identifier': identifier,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (uploadDate != null) 'upload_date': uploadDate,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImagesCompanion copyWith(
      {Value<String>? identifier,
      Value<String>? name,
      Value<String>? path,
      Value<DateTime>? uploadDate,
      Value<Uint8List>? data,
      Value<int>? rowid}) {
    return ImagesCompanion(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      path: path ?? this.path,
      uploadDate: uploadDate ?? this.uploadDate,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (uploadDate.present) {
      map['upload_date'] = Variable<DateTime>(uploadDate.value);
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('identifier: $identifier, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('uploadDate: $uploadDate, ')
          ..write('data: $data, ')
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
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tablesUpdateTimes, users, properties, images];
}
