part of 'get_stations_bloc.dart';

@immutable
sealed class GetStationsEvent {}

final class GetStations extends GetStationsEvent {
  final String adminId;

  GetStations({required this.adminId});
}

final class _GetStationsDone extends GetStationsEvent {
  final List<Station> stations;

  _GetStationsDone({required this.stations});
}

final class _GetStationsError extends GetStationsEvent {
  final String message;

  _GetStationsError({required this.message});
}
