import 'dart:async';

import 'package:balibo_station/feature/station/model/station.dart';
import 'package:balibo_station/feature/station/service/station.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_stations_event.dart';
part 'get_stations_state.dart';

class GetStationsBloc extends Bloc<GetStationsEvent, GetStationsState> {
  GetStationsBloc(this._stationService) : super(GetStationsInitial()) {
    on<GetStations>(_get);
    on<_GetStationsDone>(_done);
    on<_GetStationsError>(_error);
  }

  Timer? _debounceTimer;
  final StationService _stationService;

  StreamSubscription<List<Station>>? _getStationSubscription;

  Future<void> _get(
    GetStations event,
    Emitter<GetStationsState> emit,
  ) async {
    emit(GetStationsLoading());

    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () async {
        await _getStationSubscription?.cancel();
        _getStationSubscription =
            _stationService.getStations(event.adminId).listen((stations) {
          add(_GetStationsDone(stations: stations));
        }, onError: (error) {
          add(_GetStationsError(message: error.toString()));
        });
      },
    );
  }

  Future<void> _done(
    _GetStationsDone event,
    Emitter<GetStationsState> emit,
  ) async {
    emit(GetStationsSuccess(stations: event.stations));
  }

  Future<void> _error(
    _GetStationsError event,
    Emitter<GetStationsState> emit,
  ) async {
    emit(GetStationsFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _getStationSubscription?.cancel();
    return super.close();
  }
}
