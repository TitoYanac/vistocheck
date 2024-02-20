import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistocheck/presentation/features/auth/bloc/login_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../bloc/participant_bloc.dart';
import '../templates/participant_template.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage({super.key, required this.event});

  final Event event;

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => ParticipantBloc(realm: BlocProvider.of<LoginBloc>(context).realm),
              child: ParticipantTemplate(event: widget.event),
            );
          }
      ),
    );
  }
}
