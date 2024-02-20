import 'package:flutter/material.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../../domain/entities/participant.dart';
import '../molecules/list_tile_participant.dart';

class ListParticipantBody extends StatefulWidget {
  const ListParticipantBody(
      {super.key, required this.participants, required this.event});
  final List<Participant> participants;
  final Event event;

  @override
  State<ListParticipantBody> createState() => _ListParticipantBodyState();
}

class _ListParticipantBodyState extends State<ListParticipantBody> {
  late List<Participant> participants;
  @override
  void initState() {
    participants = widget.participants;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ListParticipantBody oldWidget) {
    if (oldWidget.participants.hashCode != widget.participants.hashCode) {
      setState(() {
        participants = widget.participants;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.participants.hashCode != participants.hashCode) {
      setState(() {
        participants = widget.participants;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final participant = widget.participants[index];
            // Usar un Key único basado en el ID del Participante
            final key = ValueKey(participant.status);
            return ListTileParticipant(
              key: key,
              participant: participant,
              event: widget.event,
            );
          },
          childCount: participants.length,
        ),
      ),
    );
  }
}
