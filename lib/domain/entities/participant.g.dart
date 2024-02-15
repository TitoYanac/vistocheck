// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Participant extends _Participant
    with RealmEntity, RealmObjectBase, RealmObject {
  Participant(
    ObjectId id,
    int dni,
    String name,
    String status,
    String statusAssist,
    DateTime registrationDate,
    ObjectId idEvent, {
    int? phone,
    String? company,
    String? district,
    String? email,
    int? age,
    String? gender,
    String? urlPhoto,
    DateTime? asistenceDate,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'dni', dni);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'statusAssist', statusAssist);
    RealmObjectBase.set(this, 'registrationDate', registrationDate);
    RealmObjectBase.set(this, 'idEvent', idEvent);
    RealmObjectBase.set(this, 'phone', phone);
    RealmObjectBase.set(this, 'company', company);
    RealmObjectBase.set(this, 'district', district);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'urlPhoto', urlPhoto);
    RealmObjectBase.set(this, 'asistenceDate', asistenceDate);
  }

  Participant._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int get dni => RealmObjectBase.get<int>(this, 'dni') as int;
  @override
  set dni(int value) => RealmObjectBase.set(this, 'dni', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  String get statusAssist =>
      RealmObjectBase.get<String>(this, 'statusAssist') as String;
  @override
  set statusAssist(String value) =>
      RealmObjectBase.set(this, 'statusAssist', value);

  @override
  DateTime get registrationDate =>
      RealmObjectBase.get<DateTime>(this, 'registrationDate') as DateTime;
  @override
  set registrationDate(DateTime value) =>
      RealmObjectBase.set(this, 'registrationDate', value);

  @override
  ObjectId get idEvent =>
      RealmObjectBase.get<ObjectId>(this, 'idEvent') as ObjectId;
  @override
  set idEvent(ObjectId value) => RealmObjectBase.set(this, 'idEvent', value);

  @override
  int? get phone => RealmObjectBase.get<int>(this, 'phone') as int?;
  @override
  set phone(int? value) => RealmObjectBase.set(this, 'phone', value);

  @override
  String? get company =>
      RealmObjectBase.get<String>(this, 'company') as String?;
  @override
  set company(String? value) => RealmObjectBase.set(this, 'company', value);

  @override
  String? get district =>
      RealmObjectBase.get<String>(this, 'district') as String?;
  @override
  set district(String? value) => RealmObjectBase.set(this, 'district', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  int? get age => RealmObjectBase.get<int>(this, 'age') as int?;
  @override
  set age(int? value) => RealmObjectBase.set(this, 'age', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String? get urlPhoto =>
      RealmObjectBase.get<String>(this, 'urlPhoto') as String?;
  @override
  set urlPhoto(String? value) => RealmObjectBase.set(this, 'urlPhoto', value);

  @override
  DateTime? get asistenceDate =>
      RealmObjectBase.get<DateTime>(this, 'asistenceDate') as DateTime?;
  @override
  set asistenceDate(DateTime? value) =>
      RealmObjectBase.set(this, 'asistenceDate', value);

  @override
  Stream<RealmObjectChanges<Participant>> get changes =>
      RealmObjectBase.getChanges<Participant>(this);

  @override
  Participant freeze() => RealmObjectBase.freezeObject<Participant>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Participant._);
    return const SchemaObject(
        ObjectType.realmObject, Participant, 'Participant', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('dni', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('statusAssist', RealmPropertyType.string),
      SchemaProperty('registrationDate', RealmPropertyType.timestamp),
      SchemaProperty('idEvent', RealmPropertyType.objectid),
      SchemaProperty('phone', RealmPropertyType.int, optional: true),
      SchemaProperty('company', RealmPropertyType.string, optional: true),
      SchemaProperty('district', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('age', RealmPropertyType.int, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('urlPhoto', RealmPropertyType.string, optional: true),
      SchemaProperty('asistenceDate', RealmPropertyType.timestamp,
          optional: true),
    ]);
  }
}
