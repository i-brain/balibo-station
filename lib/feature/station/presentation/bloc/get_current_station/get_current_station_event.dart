part of 'get_current_station_bloc.dart';

@immutable
abstract class GetCurrentStationEvent {}

final class _GetCurrentStationDone extends GetCurrentStationEvent {
  final Station station;

  _GetCurrentStationDone({required this.station});
}

final class _GetCurrentStationError extends GetCurrentStationEvent {
  final String message;

  _GetCurrentStationError({required this.message});
}
