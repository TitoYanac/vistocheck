// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Event extends _Event with RealmEntity, RealmObjectBase, RealmObject {
  Event(
    ObjectId id,
    String name,
    DateTime date,
    int duration,
    String status,
    int capacity, {
    String? description,
    String? address,
    String? urlImg,
    Iterable<ObjectId> participants = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'duration', duration);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'capacity', capacity);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'urlImg', urlImg);
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'participants', RealmList<ObjectId>(participants));
  }

  Event._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  int get duration => RealmObjectBase.get<int>(this, 'duration') as int;
  @override
  set duration(int value) => RealmObjectBase.set(this, 'duration', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  int get capacity => RealmObjectBase.get<int>(this, 'capacity') as int;
  @override
  set capacity(int value) => RealmObjectBase.set(this, 'capacity', value);

  @override
  RealmList<ObjectId> get participants =>
      RealmObjectBase.get<ObjectId>(this, 'participants')
          as RealmList<ObjectId>;
  @override
  set participants(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get address =>
      RealmObjectBase.get<String>(this, 'address') as String?;
  @override
  set address(String? value) => RealmObjectBase.set(this, 'address', value);

  @override
  String? get urlImg => RealmObjectBase.get<String>(this, 'urlImg') as String?;
  @override
  set urlImg(String? value) => RealmObjectBase.set(this, 'urlImg', value);

  @override
  Stream<RealmObjectChanges<Event>> get changes =>
      RealmObjectBase.getChanges<Event>(this);

  @override
  Event freeze() => RealmObjectBase.freezeObject<Event>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Event._);
    return const SchemaObject(ObjectType.realmObject, Event, 'Event', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('duration', RealmPropertyType.int),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('capacity', RealmPropertyType.int),
      SchemaProperty('participants', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('address', RealmPropertyType.string, optional: true),
      SchemaProperty('urlImg', RealmPropertyType.string, optional: true),
    ]);
  }
}
