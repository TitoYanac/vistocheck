import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

import '../../../../domain/entities/event.dart';
import '../../../../domain/entities/participant.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  late Realm? realm;
  ParticipantBloc({required this.realm}) : super(LoadingParticipants([], [])) {
    on<ParticipantFetch>((event, emit) async {
      emit(LoadingParticipants([], []));
      realm!.refreshAsync().then((_) {
        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);

        emit(SuccessLoadingParticipants(
            participants.toList(), participants.toList()));
      }).catchError((error) {
        emit(ErrorLoadingParticipants([], []));
      });
    });

    on<AddParticipant>((event, emit) {
      emit(AddingParticipant([], []));

      realm!.refreshAsync().then((_) {
        ObjectId idSelectedEvent = event.selectedEvent.id;

        // Obtener participantes del evento seleccionado
        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == idSelectedEvent);

        // Verificar si el participante ya existe y si el evento existe
        final existingParticipantList = participants
            .where((element) => element.dni == event.participant.dni);
        final existingEvent = realm!
            .all<Event>()
            .firstWhere((element) => element.id == idSelectedEvent);

        if (existingParticipantList.isEmpty) {
          // Crear el nuevo participante
          realm!.write(() {
            realm!.add(event.participant);
          });

          // Actualizar el evento con el nuevo participante
          realm!.write(() {
            existingEvent.participants.add(event.participant.id);
            realm!.add(existingEvent);
          });
        } else {
          final updatedParticipants = realm!
              .all<Participant>()
              .where((element) => element.idEvent == idSelectedEvent);

          emit(ErrorAddingParticipant(
            updatedParticipants.toList(),
            updatedParticipants.toList(),
          ));
          return;
        }

        // Obtener y emitir la lista actualizada de participantes
        final updatedParticipants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == idSelectedEvent);
        emit(SuccessAddingParticipant(
            updatedParticipants.toList(), updatedParticipants.toList()));
      }).catchError((error) {
        // Emitir un estado de error
        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);
        emit(ErrorAddingParticipant(
            participants.toList(), participants.toList()));
      });
    });

    on<FilterParticipants>((event, emit) {
      emit(FilteringParticipants([], []));

      realm!.refreshAsync().then((_) {
        ObjectId idSelectedEvent = event.selectedEvent.id;
        String filter = event.filter;
        String typeFilter = event.typeFilter;

        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == idSelectedEvent);

        List<Participant> filteredParticipants;

        if (typeFilter == "date") {
          try {
            DateTime filterDate = DateTime.parse(filter);
            filteredParticipants = participants
                .where((element) =>
                    element.registrationDate.day == filterDate.day &&
                    element.registrationDate.month == filterDate.month &&
                    element.registrationDate.year == filterDate.year)
                .toList();
          } catch (e) {
            filteredParticipants = participants.toList();
          }
        } else if (typeFilter == "name") {

          filteredParticipants = participants
              .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()))
              .toList();

        }else if(typeFilter == "dni"){

          int.parse(filter);
          filteredParticipants = participants
              .where((element) {
            return element.dni.toString().contains(filter.toString())
                || element.dni.toString() == filter;
          })
              .toList();
      } else{
          filteredParticipants = participants.toList();
        }

        emit(SuccessFilteringParticipants(
            participants.toList(), filteredParticipants.toList()));
      }).catchError((error) {
        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);

        emit(ErrorFilteringParticipants(participants.toList(), []));
      });
    });

    on<RecordAsistence>((event, emit) {
      emit(ModifyingParticipant([], []));

      realm!.refreshAsync().then((_) {
        String dni = event.dni;
        ObjectId idSelectedEvent = event.selectedEvent.id;
        final participants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);

        final existingParticipantList = participants.where((element) =>
            (element.dni.toString() == dni &&
                element.idEvent == idSelectedEvent));

        if (existingParticipantList.isEmpty) {
          emit(ErrorModifyingParticipant(
              participants.toList(), participants.toList()));
          return;
        }
        final existingParticipant = existingParticipantList.first;

        realm!.write(() {
          existingParticipant.asistenceDate = DateTime.now().subtract(const Duration(hours: 5));
          existingParticipant.statusAssist = "Asistio";
          realm!.add(existingParticipant);
        });

        final updatedParticipants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);
        final filteredParticipants = updatedParticipants
            .where((element) => element.dni.toString() == dni);
        emit(SuccessModifyingParticipant(
            updatedParticipants.toList(), filteredParticipants.toList()));
      }).catchError((error) {

        final updatedParticipants = realm!
            .all<Participant>()
            .where((element) => element.idEvent == event.selectedEvent.id);
        emit(ErrorModifyingParticipant(
            updatedParticipants.toList(), updatedParticipants.toList()));
      });
    });

    on<ParticipantByDniFetch>((event, emit) async {
      emit(FetchingParticipantByDni([], []));
      try {
        final participants = realm!
            .all<Participant>()
            .where((p) => p.idEvent == event.selectedEvent.id).toList();
        final participant = participants.where((p) => p.dni == int.parse(event.dni)).toList();

        emit(SuccessFetchingParticipantByDni(participants.toList(), participant.toList()));
      } catch (error) {

        final participants = realm!
            .all<Participant>()
            .where((p) => p.idEvent == event.selectedEvent.id).toList();
        emit(ErrorFetchingParticipantByDni(participants.toList(), participants.toList()));
      }
    });
  }
  void fetchParticipants(Event selectedEvent) =>
      add(ParticipantFetch(selectedEvent));

  void addParticipant(Event selectedEvent, Participant participant) =>
      add(AddParticipant(selectedEvent, participant));

  void filterParticipants(
      Event selectedEvent, String filter, String typeFilter) {
    add(FilterParticipants(selectedEvent, filter, typeFilter));
  }
  
  void fetchParticipantByDni(Event selectedEvent, String dni) =>
      add(ParticipantByDniFetch(selectedEvent, dni));

  void recordAsistence(String dni, Event selectedEvent) =>
      add(RecordAsistence(selectedEvent, dni));



}

DateTime getRandomDate() {
  var rng = Random();
  var tomorrow = DateTime.now().add(const Duration(days: 1));
  var sixMonthsLater = DateTime.now().add(const Duration(days: 180));
  var randomDate = DateTime(
      tomorrow.year,
      tomorrow.month + rng.nextInt(sixMonthsLater.month - tomorrow.month),
      tomorrow.day + rng.nextInt(30));

  return randomDate;
}

String getRandomHour() {
  var rng = Random();
  var startHour = 8 + rng.nextInt(14); // Hora de inicio aleatoria entre 8 y 22
  var endHour = startHour +
      rng.nextInt(2) +
      1; // Hora de finalización aleatoria entre 1 y 2 horas después de la hora de inicio

  return '$startHour:00 - $endHour:30';
}

class ParticipantEvent {
  Event selectedEvent;

  ParticipantEvent(this.selectedEvent);
}

class ParticipantFetch extends ParticipantEvent {
  ParticipantFetch(super.selectedEvent);
}

class ParticipantByDniFetch extends ParticipantEvent {
  String dni;
  ParticipantByDniFetch(super.selectedEvent, this.dni);
}

class RecordAsistence extends ParticipantEvent {
  String dni;
  RecordAsistence(super.selectedEvent, this.dni);
}

class AddParticipant extends ParticipantEvent {
  Participant participant;

  AddParticipant(super.selectedEvent, this.participant);
}

class FilterParticipants extends ParticipantEvent {
  String filter;
  String typeFilter;
  FilterParticipants(super.selectedEvent, this.filter, this.typeFilter);
}

class ParticipantState {
  List<Participant> participants = [];
  List<Participant> filteredParticipants = [];
  ParticipantState(List<Participant> participants,List<Participant> filteredParticipants) {
    this.participants = participants.length>1?ordenarParticipantes(participants):participants;
    this.filteredParticipants = filteredParticipants.length>1?ordenarParticipantes(filteredParticipants):filteredParticipants;

  }
  List<Participant> ordenarParticipantes(List<Participant> participants) {
    // Copia la lista original
    List<Participant> participantsOrdenados = List<Participant>.from(participants);

    // Ordena la lista por fecha de registro, de más antiguo a más reciente
    participantsOrdenados.sort((a, b) {
      return b.registrationDate.compareTo(a.registrationDate);
    });

    return participantsOrdenados;
  }
}

class LoadingParticipants extends ParticipantState {
  LoadingParticipants(super.participants, super.filteredParticipants);
}

class ErrorLoadingParticipants extends ParticipantState {
  ErrorLoadingParticipants(super.participants, super.filteredParticipants);
}

class SuccessLoadingParticipants extends ParticipantState {
  SuccessLoadingParticipants(super.participants, super.filteredParticipants);
}

class AddingParticipant extends ParticipantState {
  AddingParticipant(super.participants, super.filteredParticipants);
}

class SuccessAddingParticipant extends ParticipantState {
  SuccessAddingParticipant(super.participants, super.filteredParticipants);
}

class ErrorAddingParticipant extends ParticipantState {
  ErrorAddingParticipant(super.participants, super.filteredParticipants);
}

class FilteringParticipants extends ParticipantState {
  FilteringParticipants(super.participants, super.filteredParticipants);
}

class SuccessFilteringParticipants extends ParticipantState {
  SuccessFilteringParticipants(super.participants, super.filteredParticipants);
}

class ErrorFilteringParticipants extends ParticipantState {
  ErrorFilteringParticipants(super.participants, super.filteredParticipants);
}

class ModifyingParticipant extends ParticipantState {
  ModifyingParticipant(super.participants, super.filteredParticipants);
}

class SuccessModifyingParticipant extends ParticipantState {
  SuccessModifyingParticipant(super.participants, super.filteredParticipants);
}

class ErrorModifyingParticipant extends ParticipantState {
  ErrorModifyingParticipant(super.participants, super.filteredParticipants);
}

class FetchingParticipantByDni extends ParticipantState {
  FetchingParticipantByDni(super.participants, super.filteredParticipants);
}

class SuccessFetchingParticipantByDni extends ParticipantState {
  SuccessFetchingParticipantByDni(super.participants, super.filteredParticipants);
}

class ErrorFetchingParticipantByDni extends ParticipantState {
  ErrorFetchingParticipantByDni(super.participants, super.filteredParticipants);
}