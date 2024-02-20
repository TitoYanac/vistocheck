import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:realm/realm.dart';

import 'domain/entities/event.dart';
import 'domain/entities/participant.dart';
import 'domain/entities/user_data.dart';
import 'presentation/features/auth/bloc/login_bloc.dart';
import 'presentation/features/auth/widgets/pages/login_page.dart';

Future<void> main() async {
  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize config
  final App app = App(AppConfiguration('events-dxmrb',
      defaultRequestTimeout: const Duration(seconds: 120)));
  // Log in as anonymous
  User? user = await app.logIn(Credentials.anonymous());
  // Initialize Realm
  final realm = Realm(Configuration.flexibleSync(
      user, [Participant.schema, Event.schema, UserData.schema]));
  // Add subscriptions to the realm
  const truePredicate = 'TRUEPREDICATE';
  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions.add(realm.query<Participant>(truePredicate));
    mutableSubscriptions.add(realm.query<Event>(truePredicate));
    mutableSubscriptions.add(realm.query<UserData>(truePredicate));
  });
  runApp(MyApp(app: app, user: user, realm: realm));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.app, required this.user, required this.realm});

  final App app;
  final User user;
  final Realm realm;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(app: app, user: user, realm: realm),
      child: MaterialApp(
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
        home: const LoginPage(),
        //home: const EventPage(),
      ),
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
