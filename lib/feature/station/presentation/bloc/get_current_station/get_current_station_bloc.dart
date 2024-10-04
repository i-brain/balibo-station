import 'dart:async';
import 'package:balibo_station/feature/station/model/station.dart';
import 'package:balibo_station/feature/station/service/station.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_current_station_event.dart';
part 'get_current_station_state.dart';

class GetCurrentStationBloc
    extends Bloc<GetCurrentStationEvent, GetCurrentStationState> {
  GetCurrentStationBloc(this._stationService)
      : super(GetCurrentStationInitial()) {
    _currentStationSubscription =
        _stationService.getCurrentStation().listen((station) {
      add(_GetCurrentStationDone(station: station));
    }, onError: (error) {
      add(_GetCurrentStationError(message: error.toString()));
    });
    on<_GetCurrentStationDone>(_done);
    on<_GetCurrentStationError>(_error);
  }

  final StationService _stationService;

  StreamSubscription<Station>? _currentStationSubscription;

  Future<void> _done(
    _GetCurrentStationDone event,
    Emitter<GetCurrentStationState> emit,
  ) async {
    emit(GetCurrentStationSuccess(station: event.station));
  }

  Future<void> _error(
    _GetCurrentStationError event,
    Emitter<GetCurrentStationState> emit,
  ) async {
    emit(GetCurrentStationFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _currentStationSubscription?.cancel();
    return super.close();
  }
}
