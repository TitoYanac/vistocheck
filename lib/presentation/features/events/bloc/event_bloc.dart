import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

import '../../../../domain/entities/event.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  late Realm? realm;



  EventBloc({required this.realm}) : super(LoadingEvents([], [])) {
    on<EventFetch>((event, emit) async {
      emit(LoadingEvents([], []));
      try {
        await realm!.refreshAsync();
        final RealmResults<Event> events = realm!.all<Event>();
        List<Event> eventosOrdenados = ordenarEventos(events);

        emit(SuccessLoadingEvents(eventosOrdenados, eventosOrdenados));
      } catch (error) {
        emit(ErrorLoadingEvents([], []));
      }
    });


    on<AddEvent>((event, emit) {
      emit(AddingEvent([], []));
      realm!.refreshAsync().then((_) {
        final Event newEvent = crearNuevoEvento();
        realm!.write(() {
          realm!.add(newEvent);
        });
        final RealmResults<Event> events = realm!.all<Event>();
        List<Event> eventosOrdenados = ordenarEventos(events);

        emit(SuccessAddingEvent(eventosOrdenados, eventosOrdenados));
      }).catchError((error) {
        final RealmResults<Event> events = realm!.all<Event>();
        List<Event> eventosOrdenados = ordenarEventos(events);
        emit(ErrorAddingEvent(eventosOrdenados, eventosOrdenados));
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
            String filterDate = filter.replaceAll("-", "").replaceAll("/", "");
            filteredEventsList = events
                .where((element){
                  DateTime date = element.date;
                  String dateDB = "${date.day.toString().length == 1 ? "0${date.day}" : date.day}${date.month.toString().length == 1 ? "0${date.month}" : date.month}${date.year}";
                  return dateDB.contains(filterDate);
            }).toList();
          } else if (typeFilter == "name") {
            filteredEventsList = events
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()))
                .toList();
          } else {
            filteredEventsList = [];
          }

          List<Event> eventosOrdenadosFiltrados = ordenarEventos(filteredEventsList);
          List<Event> eventosOrdenados = ordenarEventos(events);
          emit(SuccessFilteringEvents(eventosOrdenados, eventosOrdenadosFiltrados));
        } catch (e) {
          List<Event> eventosOrdenados = ordenarEventos(events);
          emit(ErrorFilteringEvents(eventosOrdenados, []));
        }
      }).catchError((error) {
        final RealmResults<Event> events = realm!.all<Event>();
        List<Event> eventosOrdenados = ordenarEventos(events);

        emit(ErrorFilteringEvents(eventosOrdenados, []));
      });
    });
    on<UpdateStatus>((event, emit) {
      realm!.refreshAsync().then((_) {
        final RealmResults<Event> events = realm!.all<Event>();

        // Recorre todos los eventos
        for (final event in events) {
          // Calcula el nuevo estado del evento
          String newStatus = validateStatus(event);

          // Actualiza el estado del evento si es necesario
          if (event.status != newStatus) {
            realm!.write(() {
              event.status = newStatus;
            });
          }
        }
      });
    });

  }
  void fetchEvents() => add(EventFetch());

  void addEvent() => add(AddEvent());

  void filterEvents(String filter, String typeFilter) =>
      add(FilterEvents(filter, typeFilter));
  String validateStatus(Event event) {
    DateTime dateInitEvent = event.date.add(const Duration(hours: 5)).toLocal();
    DateTime dateEndEvent = dateInitEvent.add(Duration(minutes: event.duration));
    DateTime now = DateTime.now();

    if (dateInitEvent.isBefore(now) && dateEndEvent.isAfter(now)) {
      return "En curso";
    }
    if (dateEndEvent.isBefore(now)) {
      return "Finalizado";
    }

    if (dateInitEvent.isAfter(now.add(const Duration(days: 3)))) {
      return "Proximamente";
    }

    return "En pocos dias";
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

  List<Event> ordenarEventos(events) {
    // Copia la lista original
    List<Event> eventosOrdenados = List<Event>.from(events);

    // Obtiene la fecha actual
    DateTime ahora = DateTime.now().subtract(const Duration(hours: 5)).toLocal();

    // Filtra los eventos que finalizaron hace más de un día
    eventosOrdenados = eventosOrdenados.where((event) {
      DateTime dateEndEvent = event.date.toLocal().add(Duration(minutes: event.duration));
      return dateEndEvent.isAfter(ahora.subtract(const Duration(days: 1)));
    }).toList();

    // Ordena la lista
    eventosOrdenados.sort((a, b) {
      DateTime aEnd = a.date.toLocal().add(Duration(minutes: a.duration));
      DateTime bEnd = b.date.toLocal().add(Duration(minutes: b.duration));

      // Comprueba si el evento ya pasó
      bool aPasado = aEnd.isBefore(ahora);
      bool bPasado = bEnd.isBefore(ahora);

      bool aEnCurso = a.date.toLocal().isBefore(ahora) && aEnd.isAfter(ahora);
      bool bEnCurso = b.date.toLocal().isBefore(ahora) && bEnd.isAfter(ahora);

      if (aEnCurso && bEnCurso) {
        // Si ambos eventos están en curso, ordena de los que están más próximos a terminar a los que tienen más tiempo restante
        return aEnd.compareTo(bEnd);
      } else if (aEnCurso) {
        // Si solo a está en curso, a va primero
        return -1;
      } else if (bEnCurso) {
        // Si solo b está en curso, b va primero
        return 1;
      } else if (aPasado && bPasado) {
        // Si ambos eventos ya pasaron, ordena de más reciente a más antiguo
        return bEnd.compareTo(aEnd);
      } else if (aPasado) {
        // Si solo a ya pasó, b va primero
        return 1;
      } else if (bPasado) {
        // Si solo b ya pasó, a va primero
        return -1;
      } else {
        // Si ninguno de los eventos ha pasado, ordena de más cercano a más lejano
        return a.date.toLocal().compareTo(b.date.toLocal());
      }
    });

    return eventosOrdenados;
  }

  void updateStatus() => add(UpdateStatus());

}

abstract class EventEvent {}

class EventFetch extends EventEvent {}

class AddEvent extends EventEvent {}

class UpdateStatus extends EventEvent {

}

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
