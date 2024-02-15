import 'package:realm/realm.dart';
part 'participant.g.dart';

@RealmModel()
class _Participant {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  // variables de la clase obligatorias
  late int dni;
  late String name;
  late String status;
  late String statusAssist;
  late DateTime registrationDate;
  // variables de la clase opcional
  late ObjectId idEvent;
  late int? phone;
  late String? company;
  late String? district;
  late String? email;
  late int? age;
  late String? gender;
  late String? urlPhoto;
  late DateTime? asistenceDate;
}
