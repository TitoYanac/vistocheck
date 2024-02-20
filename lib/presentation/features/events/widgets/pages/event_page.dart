import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistocheck/presentation/features/auth/bloc/login_bloc.dart';

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

      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => EventBloc(realm: BlocProvider.of<LoginBloc>(context).realm),
              child: const EventTemplate(),
            );
          }
      ),
    )
    ;
  }
}
