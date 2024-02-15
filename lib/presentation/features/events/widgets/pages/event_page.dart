import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/realm_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../templates/event_template.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: BlocBuilder<RealmBloc, RealmState>(
          builder: (context, state) {
            if (state is RealmLoaded) {
              return BlocProvider(
                create: (context) => EventBloc(realm: state.realm),
                child: const EventTemplate(),
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
