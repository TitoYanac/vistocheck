import 'package:flutter/material.dart';

import '../../../../../domain/entities/event.dart';
import '../molecules/list_tile_event.dart';

class ListEventBody extends StatefulWidget {
  const ListEventBody({super.key, required this.events});
  final List<Event> events;

  @override
  State<ListEventBody> createState() => _ListEventBodyState();
}

class _ListEventBodyState extends State<ListEventBody> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final event = widget.events[index];
            // Usar un Key único basado en el ID del evento
            final key = ValueKey(event.status);
            return ListTileEvent(
              key: key,
              event: event,
            );
          },
          childCount: widget.events.length,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
        ),
      ),
    );
  }
}
