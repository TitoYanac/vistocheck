import 'package:realm/realm.dart';

part 'event.g.dart';

@RealmModel()
class _Event {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  // variables de la clase obligatorias
  late String name;
  late DateTime date;
  late int duration; // minutos de duración
  late String status;
  late int capacity;
  late List<ObjectId> participants = [];
  // variables de la clase opcional
  late String? description;
  late String? address;
  late String? urlImg;
}
