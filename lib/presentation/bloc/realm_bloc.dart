import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

import '../../data/datasource/realm_provider.dart';

class RealmBloc extends Bloc<RealmEvent, RealmState> {
  Realm? realm;
  RealmBloc() : super(RealmInitial(null)) {
    on<FetchRealm>((event, emit) async {
      emit(RealmLoading(null));
      try {
        realm = await RealmProvider.initializeRealm();
        emit(RealmLoaded(realm));
      } catch (e) {
        emit(RealmLoadError(null));
      }
    });
  }

  void fetchRealm() => add(FetchRealm());
}

abstract class RealmEvent {}

class FetchRealm extends RealmEvent {}

abstract class RealmState {
  Realm? realm;
  RealmState(this.realm);
}

class RealmInitial extends RealmState {
  RealmInitial(super.realm);
}

class RealmLoading extends RealmState {
  RealmLoading(super.realm);
}

class RealmLoaded extends RealmState {
  RealmLoaded(super.realm);
}

class RealmLoadError extends RealmState {
  RealmLoadError(super.realm);
}
