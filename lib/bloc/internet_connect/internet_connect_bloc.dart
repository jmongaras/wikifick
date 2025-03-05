import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_connect_event.dart';
part 'internet_connect_state.dart';

class InternetConnectBloc
    extends Bloc<InternetConnectEvent, InternetConnectState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  InternetConnectBloc() : super(InternetConnectInitial()) {
    on<ConnectedInternetEvent>(
        (event, emit) => emit(InternetConnectedSucess()));
    on<NotConnectedInternetEvent>(
        (event, emit) => emit(InternetConnectedFailure()));
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      bool hasConnection = results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (hasConnection) {
        add(ConnectedInternetEvent());
      } else {
        add(NotConnectedInternetEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
