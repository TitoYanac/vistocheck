import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/bloc/realm_bloc.dart';
import 'presentation/features/events/widgets/pages/event_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    runApp(
      BlocProvider(
        create: (context) => RealmBloc(),
        child: const MyApp(),
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RealmBloc>(context).fetchRealm();
    return MaterialApp(
      title: "Vistocheck",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // Español
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EventPage(),
    );
  }
}
/*

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<EventBloc>(context).fetchEvents();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<EventBloc>(context).addEvent();
                    },
                    child: const Text("Add Event"),
                  ),
                ),
                ListEventBody(events: state.events),
              ],
            );
          }
        )
      ),
    );
  }
}
*/
