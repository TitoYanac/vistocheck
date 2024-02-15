import '../entities/event.dart';

class EventManager {
  List<Event> events = [];

  void addEvent(Event event) {
    events.add(event);
  }

  List<Event> getEvents() {
    return events;
  }

}