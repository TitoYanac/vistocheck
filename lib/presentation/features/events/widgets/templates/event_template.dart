import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/messages/scaffold_messages.dart';
import '../../../auth/bloc/login_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../organisms/banner_event_appbar.dart';
import '../organisms/list_event_body.dart';
import '../organisms/search_event_appbar.dart';

class EventTemplate extends StatefulWidget {
  const EventTemplate({super.key});

  @override
  State<EventTemplate> createState() => _EventTemplateState();
}

class _EventTemplateState extends State<EventTemplate> {
  @override
  void initState() {
    BlocProvider.of<EventBloc>(context).fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is ErrorLoadingEvents
          || state is ErrorFilteringEvents
          || state is ErrorAddingEvent) {
            showErrorMessage(context, "Error al cargar los Eventos");
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<EventBloc>(context).fetchEvents();
            },
            child: CustomScrollView(
              slivers: [
                const BannerEventAppBar(
                  title: 'Eventos',
                ),
                SearchEventAppBar(
                  onChanged: (searchText, typeFilter) =>
                      BlocProvider.of<EventBloc>(context)
                          .filterEvents(searchText, typeFilter),
                ),
                ListEventBody(events: state.filteredEvents),
              ],
            ),
          );
        },
      ),
      floatingActionButton: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return state.userData?.role == "admin"?FloatingActionButton(
            onPressed: () {
              BlocProvider.of<EventBloc>(context).updateStatus();
            },
            child: const Icon(
              Icons.refresh,
              color: Colors.red,
            ),
          ):Container();
        },

      )
    );
  }
}
