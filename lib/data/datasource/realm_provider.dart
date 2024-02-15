import 'package:realm/realm.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/participant.dart';

class RealmProvider {
  static Future<Realm> initializeRealm() async {
    final app = App(AppConfiguration('events-dxmrb',
        defaultRequestTimeout: const Duration(seconds: 120)));
    final user = await app.logIn(Credentials.anonymous());

    final realm = Realm(Configuration.flexibleSync(user, [Participant.schema, Event.schema]));
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.query<Participant>('TRUEPREDICATE'));
      mutableSubscriptions.add(realm.query<Event>('TRUEPREDICATE'));
    });
    await realm.subscriptions.waitForSynchronization();
    await realm.syncSession.waitForDownload();
    return realm;
  }
}
