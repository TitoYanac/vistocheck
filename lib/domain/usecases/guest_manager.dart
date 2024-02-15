import '../entities/participant.dart';

class ParticipantManager {
  List<Participant> participants = [];

  void addParticipant(Participant p) {
    participants.add(p);
  }

  List<Participant> getparticipants() {
    return participants;
  }

  Participant getParticipantByName(String name) {
    return participants.firstWhere((p) => p.name == name);
  }

  Participant getParticipantByPhone(int phone) {
    return participants.firstWhere((p) => p.phone == phone);
  }

  Participant getParticipantByDni(int dni) {
    return participants.firstWhere((p) => p.dni == dni);
  }


}