import 'package:realm/realm.dart';

part 'user_data.g.dart';

@RealmModel()
class _UserData {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  // variables de la clase obligatorias
  late String userName;
  late String password;
  late String status; // activo o inactivo o suspendido
  late DateTime dateCreation;
  late DateTime lastDateModified;
  late bool isOnline;
  late DateTime lastLogin;
  late DateTime lastLogout;
  late String? fullName;
  late int? phone;
  late int? age;
  late String? email;
  late bool? verifiedEmail;
  late String? role; //admin o normal o guest
  late String? urlImg;
}
