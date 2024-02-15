import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

import '../../../../domain/entities/event.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  late Realm? realm;
  EventBloc({required this.realm}) : super(LoadingEvents([], [])) {
    on<EventFetch>((event, emit) {
      emit(LoadingEvents([], []));
      realm!.refreshAsync().then((_) {
        final RealmResults<Event> events = realm!.all<Event>();
        emit(SuccessLoadingEvents(events.toList(), events.toList()));
      }).catchError((error) {
        emit(ErrorLoadingEvents([], []));
      });
    });

    on<AddEvent>((event, emit) {
      emit(AddingEvent([], []));
      realm!.refreshAsync().then((_) {
        final Event newEvent = crearNuevoEvento();
        realm!.write(() {
          realm!.add(newEvent);
        });
        final RealmResults<Event> events = realm!.all<Event>();
        emit(SuccessAddingEvent(events.toList(), events.toList()));
      }).catchError((error) {
        final RealmResults<Event> events = realm!.all<Event>();
        emit(ErrorAddingEvent(events.toList(), events.toList()));
      });
    });

    on<FilterEvents>((event, emit) {
      emit(FilteringEvents([], []));
      realm!.refreshAsync().then((_) {
        final RealmResults<Event> events = realm!.all<Event>();
        String filter = event.filter;
        String typeFilter = event.typeFilter;
        List<Event> filteredEventsList;

        try {
          if (typeFilter == "date") {
            DateTime filterDate = DateTime.parse(filter);
            filteredEventsList = events
                .where((element) => element.date.isAtSameMomentAs(filterDate))
                .toList();
          } else if (typeFilter == "name") {
            filteredEventsList = events
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()))
                .toList();
          } else {
            filteredEventsList = [];
          }
          emit(SuccessFilteringEvents(events.toList(), filteredEventsList));
        } catch (e) {
          emit(ErrorFilteringEvents(events.toList(), []));
        }
      }).catchError((error) {
        final RealmResults<Event> events = realm!.all<Event>();
        emit(ErrorFilteringEvents(events.toList(), []));
      });
    });
  }
  void fetchEvents() => add(EventFetch());

  void addEvent() => add(AddEvent());

  void filterEvents(String filter, String typeFilter) =>
      add(FilterEvents(filter, typeFilter));

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
    var startHour =
        8 + rng.nextInt(14); // Hora de inicio aleatoria entre 8 y 22
    var endHour = startHour +
        rng.nextInt(2) +
        1; // Hora de finalización aleatoria entre 1 y 2 horas después de la hora de inicio

    return '$startHour:00 - $endHour:30';
  }

  Event crearNuevoEvento() {
    ObjectId id = ObjectId();
    // variables de la clase obligatorias
    String name =
        "Buen uso del Kit de Presión y medición de Glicol con refractómetro";
    DateTime date = getRandomDate();
    int duration = 120; // minutos de duración
    String status = "Activo";
    int capacity = 60;
    List<ObjectId> participants = [];
    // variables de la clase opcional
    String description =
        "Buen uso del Kit de Presión y medición de Glicol con refractómetro";
    String address = "Senati - Av. Alfredo Mendiola 3540, Lima, Peru";
    Event newEvent = Event(
      id,
      name,
      date,
      duration, //duracion en minutos
      status,
      capacity, //aforo
      participants: participants, //participants
      description: description,
      address: address,
    );
    return newEvent;
  }
}

abstract class EventEvent {}

class EventFetch extends EventEvent {}

class AddEvent extends EventEvent {}

class FilterEvents extends EventEvent {
  String filter;
  String typeFilter;
  FilterEvents(this.filter, this.typeFilter);
}

class EventState {
  List<Event> events;
  List<Event> filteredEvents;
  EventState(this.events, this.filteredEvents);
}

class LoadingEvents extends EventState {
  LoadingEvents(super.events, super.filteredEvents);
}

class ErrorLoadingEvents extends EventState {
  ErrorLoadingEvents(super.events, super.filteredEvents);
}

class SuccessLoadingEvents extends EventState {
  SuccessLoadingEvents(super.events, super.filteredEvents);
}

class AddingEvent extends EventState {
  AddingEvent(super.events, super.filteredEvents);
}

class SuccessAddingEvent extends EventState {
  SuccessAddingEvent(super.events, super.filteredEvents);
}

class ErrorAddingEvent extends EventState {
  ErrorAddingEvent(super.events, super.filteredEvents);
}

class FilteringEvents extends EventState {
  FilteringEvents(super.events, super.filteredEvents);
}

class ErrorFilteringEvents extends EventState {
  ErrorFilteringEvents(super.events, super.filteredEvents);
}

class SuccessFilteringEvents extends EventState {
  SuccessFilteringEvents(super.events, super.filteredEvents);
}
