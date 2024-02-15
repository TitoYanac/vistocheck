import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/event.dart';
import '../../../../bloc/realm_bloc.dart';
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

      child: BlocBuilder<RealmBloc, RealmState>(
          builder: (context, state) {
            if (state is RealmLoaded) {
              return BlocProvider(
                create: (context) => ParticipantBloc(realm: state.realm),
                child: ParticipantTemplate(event: widget.event),
              );
            } else if( state is RealmLoadError){
              return const Scaffold(
                  body: Center(
                    child: Text("Error..."),
                  )
              );
            } else {
              return const Scaffold(
                  body: Center(
                    child: Text("Loading..."),
                  )
              );
            }
          }
      ),
    )
    ;
  }
}
