// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserData extends _UserData
    with RealmEntity, RealmObjectBase, RealmObject {
  UserData(
    ObjectId id,
    String userName,
    String password,
    String status,
    DateTime dateCreation,
    DateTime lastDateModified,
    bool isOnline,
    DateTime lastLogin,
    DateTime lastLogout, {
    String? fullName,
    int? phone,
    int? age,
    String? email,
    bool? verifiedEmail,
    String? role,
    String? urlImg,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'dateCreation', dateCreation);
    RealmObjectBase.set(this, 'lastDateModified', lastDateModified);
    RealmObjectBase.set(this, 'isOnline', isOnline);
    RealmObjectBase.set(this, 'lastLogin', lastLogin);
    RealmObjectBase.set(this, 'lastLogout', lastLogout);
    RealmObjectBase.set(this, 'fullName', fullName);
    RealmObjectBase.set(this, 'phone', phone);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'verifiedEmail', verifiedEmail);
    RealmObjectBase.set(this, 'role', role);
    RealmObjectBase.set(this, 'urlImg', urlImg);
  }

  UserData._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String;
  @override
  set userName(String value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  DateTime get dateCreation =>
      RealmObjectBase.get<DateTime>(this, 'dateCreation') as DateTime;
  @override
  set dateCreation(DateTime value) =>
      RealmObjectBase.set(this, 'dateCreation', value);

  @override
  DateTime get lastDateModified =>
      RealmObjectBase.get<DateTime>(this, 'lastDateModified') as DateTime;
  @override
  set lastDateModified(DateTime value) =>
      RealmObjectBase.set(this, 'lastDateModified', value);

  @override
  bool get isOnline => RealmObjectBase.get<bool>(this, 'isOnline') as bool;
  @override
  set isOnline(bool value) => RealmObjectBase.set(this, 'isOnline', value);

  @override
  DateTime get lastLogin =>
      RealmObjectBase.get<DateTime>(this, 'lastLogin') as DateTime;
  @override
  set lastLogin(DateTime value) =>
      RealmObjectBase.set(this, 'lastLogin', value);

  @override
  DateTime get lastLogout =>
      RealmObjectBase.get<DateTime>(this, 'lastLogout') as DateTime;
  @override
  set lastLogout(DateTime value) =>
      RealmObjectBase.set(this, 'lastLogout', value);

  @override
  String? get fullName =>
      RealmObjectBase.get<String>(this, 'fullName') as String?;
  @override
  set fullName(String? value) => RealmObjectBase.set(this, 'fullName', value);

  @override
  int? get phone => RealmObjectBase.get<int>(this, 'phone') as int?;
  @override
  set phone(int? value) => RealmObjectBase.set(this, 'phone', value);

  @override
  int? get age => RealmObjectBase.get<int>(this, 'age') as int?;
  @override
  set age(int? value) => RealmObjectBase.set(this, 'age', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  bool? get verifiedEmail =>
      RealmObjectBase.get<bool>(this, 'verifiedEmail') as bool?;
  @override
  set verifiedEmail(bool? value) =>
      RealmObjectBase.set(this, 'verifiedEmail', value);

  @override
  String? get role => RealmObjectBase.get<String>(this, 'role') as String?;
  @override
  set role(String? value) => RealmObjectBase.set(this, 'role', value);

  @override
  String? get urlImg => RealmObjectBase.get<String>(this, 'urlImg') as String?;
  @override
  set urlImg(String? value) => RealmObjectBase.set(this, 'urlImg', value);

  @override
  Stream<RealmObjectChanges<UserData>> get changes =>
      RealmObjectBase.getChanges<UserData>(this);

  @override
  UserData freeze() => RealmObjectBase.freezeObject<UserData>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(UserData._);
    return const SchemaObject(ObjectType.realmObject, UserData, 'UserData', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('dateCreation', RealmPropertyType.timestamp),
      SchemaProperty('lastDateModified', RealmPropertyType.timestamp),
      SchemaProperty('isOnline', RealmPropertyType.bool),
      SchemaProperty('lastLogin', RealmPropertyType.timestamp),
      SchemaProperty('lastLogout', RealmPropertyType.timestamp),
      SchemaProperty('fullName', RealmPropertyType.string, optional: true),
      SchemaProperty('phone', RealmPropertyType.int, optional: true),
      SchemaProperty('age', RealmPropertyType.int, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('verifiedEmail', RealmPropertyType.bool, optional: true),
      SchemaProperty('role', RealmPropertyType.string, optional: true),
      SchemaProperty('urlImg', RealmPropertyType.string, optional: true),
    ]);
  }
}
