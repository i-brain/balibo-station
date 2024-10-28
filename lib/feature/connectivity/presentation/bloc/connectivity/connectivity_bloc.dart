import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      add(ConnectivityChanged(connectivity: result));
    });
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  void _onConnectivityChanged(ConnectivityChanged event, emit) async {
    final connectivity = event.connectivity;
    if (connectivity.contains(ConnectivityResult.none)) {
      emit(ConnectivityNone());
    } else {
      emit(ConnectivityInternetConnection());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
